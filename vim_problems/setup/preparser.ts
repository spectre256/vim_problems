import { spawnSync } from 'node:child_process'
import { copyFileSync, mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { dirname, join, resolve } from 'node:path'
import { definePreparserSetup } from '@slidev/types'

// Expands, at build time:
//
//   ```vim-run
//   script: ../sol1.vim
//   input: ../input1.txt
//   show: script output        (optional; any of script/input/output, default all)
//   lang: bash                 (optional; script highlighting, default vim)
//   attrs: {1|2-3|all}         (optional; Slidev code-block attrs for the script)
//   ```
//
// Output is only computed when shown, so `show: script` never runs anything.
//
// into plain code blocks holding the script, the input, and the buffer left
// after running `nvim -s script input`. Paths are relative to slides.md.

const caret = (s: string) => s
  .replace(/\r\n?/g, m => m === '\r\n' ? '^M\n' : '^M')
  .replace(/[\x00-\x08\x0B-\x1F\x7F]/g, c => c === '\x7F' ? '^?' : `^${String.fromCharCode(c.charCodeAt(0) + 64)}`)

const fence = (lang: string, body: string) => {
  const ticks = '`'.repeat(Math.max(3, ...(body.match(/`+/g) ?? []).map(t => t.length + 1)))
  return [`${ticks}${lang}`, ...body.replace(/\n$/, '').split('\n'), ticks]
}

function run(script: string, input: string | undefined): string {
  const dir = mkdtempSync(join(tmpdir(), 'vim-run-'))
  try {
    const buf = join(dir, 'buffer')
    const out = join(dir, 'out')
    if (input)
      copyFileSync(input, buf)
    // Leave whatever mode the script ended in, dump the buffer, and quit.
    const keys = join(dir, 'keys')
    writeFileSync(keys, `${readFileSync(script, 'latin1')}\x1B\x1B:sil! w! ${out}\r:qa!\r`, 'latin1')
    const res = spawnSync('nvim', ['--headless', '-n', '-u', 'NONE', '-i', 'NONE', '-s', keys, buf], {
      cwd: dir,
      stdio: 'ignore',
      timeout: 15_000,
      killSignal: 'SIGKILL',
    })
    if (res.error || res.signal)
      return `vim-run failed: ${res.error?.message ?? `killed by ${res.signal} (timed out?)`}`
    try {
      return readFileSync(out, 'utf8')
    }
    catch {
      return 'vim-run failed: script left nothing to write'
    }
  }
  finally {
    rmSync(dir, { recursive: true, force: true })
  }
}

export default definePreparserSetup(({ filepath }) => [{
  name: 'vim-run',
  transformRawLines(lines) {
    for (let i = 0; i < lines.length; i++) {
      if (lines[i].trim() !== '```vim-run')
        continue
      const end = lines.findIndex((l, j) => j > i && l.trim() === '```')
      if (end < 0)
        break
      const opts: Record<string, string> = {}
      for (const l of lines.slice(i + 1, end)) {
        const m = l.match(/^\s*(\w+)\s*:\s*(.*?)\s*$/)
        if (m)
          opts[m[1]] = m[2]
      }
      const at = (p?: string) => p && resolve(dirname(filepath), p)
      const script = at(opts.script)
      const input = at(opts.input)
      const show = (opts.show ?? 'script input output').split(/[\s,]+/)

      const blocks: string[] = []
      if (!script) {
        blocks.push(...fence('text', 'vim-run: missing `script:`'))
      }
      else {
        if (show.includes('script'))
          blocks.push(...fence(`${opts.lang ?? 'vim'} ${opts.attrs ?? ''}`.trim(), caret(readFileSync(script, 'utf8'))))
        if (show.includes('input') && input)
          blocks.push(...fence('text', readFileSync(input, 'utf8')))
        if (show.includes('output'))
          blocks.push(...fence('text', run(script, input)))
      }
      lines.splice(i, end - i + 1, ...blocks)
      i += blocks.length - 1
    }
  },
}])
