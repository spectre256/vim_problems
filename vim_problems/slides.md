---
theme: seriph
title: :help!
info: |
  Solving problems in the greatest programming environment of all time: VIM
class: text-center
drawings:
  persist: false
transition: slide-left
duration: 35min
# hash routing (/slides/#/3) so the dumb static server never sees deep links
routerMode: hash
---

# :help!

### Solving problems in the greatest programming environment of all time: VIM

By Ellis Gibbons

<!--
Welcome! Quick vibe check: who here uses Vim? Who here has *tried* to quit Vim?

Tonight: a bunch of problems that nobody should solve in a text editor, solved in a text editor.
-->

---
layout: section
---

<div class="tt-fade" aria-hidden="true">
    <div class="tt-bg">
        <div v-for="r in 22" :key="r" class="tt-row" :style="{ marginLeft: (r % 2 ? 0 : -3.2) + 'em' }">
            <span v-for="n in 14" :key="n">{{ [':g/re/p', ':s', 'q@qq@q', ':norm', 'gngf', ':so!'][(n + r * 2) % 6] }}</span>
        </div>
    </div>
</div>

# Tools of the Trade
## A field guide to the Vim zoo

<style>
.tt-bg { position: absolute; inset: -60% -40%; transform: rotate(-24deg); z-index: 0; pointer-events: none; user-select: none;
  font-family: var(--slidev-code-font-family, monospace); font-size: 1.6rem; line-height: 2.6; color: #888; opacity: .22; white-space: nowrap; }
.tt-row span { display: inline-block; width: 6.4em; }
.tt-fade { position: absolute; inset: 0; z-index: 0; overflow: hidden; pointer-events: none;
  -webkit-mask-image: radial-gradient(ellipse 45% 32% at center, transparent 45%, black 100%);
  mask-image: radial-gradient(ellipse 45% 32% at center, transparent 45%, black 100%); }
h1, h2 { position: relative; z-index: 1; }
</style>



---

# Normal Mode

<div class="ex-grid">
<div class="ex-head">keys</div><div class="ex-head">what it does</div>

<div v-click="1" class="ex-cmd"><span class="c-cmd">/</span></div>
<div v-click="1" class="ex-desc">search forward for a pattern</div>

<div v-click="2" class="ex-cmd"><span class="c-cmd">n<span class="ex-sep">/</span>N</span></div>
<div v-click="2" class="ex-desc">jump to the next / previous match</div>

<div v-click="3" class="ex-cmd"><span class="c-cmd">gn</span></div>
<div v-click="3" class="ex-desc">select the next match</div>

<div v-click="4" class="ex-cmd"><span class="c-cmd">gf</span></div>
<div v-click="4" class="ex-desc">open the filename under the cursor</div>

<div v-click="5" class="ex-cmd"><span class="c-cmd">q</span></div>
<div v-click="5" class="ex-desc">start / stop recording a macro</div>

<div v-click="6" class="ex-cmd"><span class="c-cmd">@</span></div>
<div v-click="6" class="ex-desc">execute a macro</div>
</div>

<!--
The handful of Normal-mode keys that show up over and over tonight.

[click] `/` — search. Type a pattern, hit Enter, cursor jumps to the next match.

[click] `n` / `N` — repeat that search forward / backward.

[click] `gn` — visually select the next match. `cgn` = change the next match; `.` repeats it.

[click] `gf` — "go to file": open the filename under the cursor. server.vim leans on `gngf`: jump to the match, open it as a file.

[click] `q` — start recording keystrokes; `q` again stops.

[click] `@` — replay what you recorded.
-->

---
clicks: 6
---

# Ex Commands

<div class="ex-grid">
<div class="ex-head">command</div><div class="ex-head">what it does</div>

<div v-click="1" class="ex-cmd">:<span class="c-cmd">s</span><span class="c-body">/pat/rep/</span></div>
<div v-click="1" class="ex-desc">find &amp; replace with a regex</div>

<div v-click="2" class="ex-cmd">:<span class="c-cmd">g</span><span class="ex-grep c-body" :class="{ on: $clicks >= 3 }">/re/p</span></div>
<div v-click="2" class="ex-desc">run a command on every line that matches
<div class="ex-grep ex-note" :class="{ on: $clicks >= 3 }"><b>g</b>lobal / <b>re</b>gex / <b>p</b>rint — where <b>grep</b> got its name</div></div>

<div v-click="4" class="ex-cmd">:<span class="c-cmd">norm</span></div>
<div v-click="4" class="ex-desc">type Normal-mode keys on each line</div>

<div v-click="5" class="ex-cmd">:<span class="c-cmd">so</span></div>
<div v-click="5" class="ex-desc">run a file as Ex commands</div>

<div v-click="6" class="ex-cmd">:<span class="c-cmd">so!</span></div>
<div v-click="6" class="ex-desc">replay a file <b>as if you typed it</b></div>
</div>

<style>
.ex-grep { display: inline-block; max-width: 0; opacity: 0; overflow: hidden; vertical-align: bottom; white-space: nowrap;
  transition: max-width .5s ease, opacity .5s ease; }
.ex-grep.on { max-width: 20rem; opacity: 1; }
.ex-note { display: block; max-width: none; max-height: 0; font-size: 1.1rem; color: inherit; opacity: 0; transition: max-height .5s, opacity .5s; }
.ex-note.on { max-height: 3rem; opacity: .75; }
</style>

<!--
Five commands carry almost every script tonight.

[click] `:s` — substitute. Watch for `\v` (very magic), `\zs`/`\ze`, and `\=expr`: once the replacement is an expression, `:s` is a map() over regex matches. Flag `n` counts matches without replacing — sol1 counts water that way.

[click] `:g` — run any Ex command on every matching line. `:v` is the inverse. With a range it's an if-statement: `:1g/^BREW /…` runs iff line 1 matches; `:1v` is the else (server.vim).

[click] And `:g/re/p` — global, regex, print. That's literally where `grep` got its name.

[click] `:norm` — type Normal-mode keys on each line. `:g` + `:norm` = "do these keystrokes on every matching line". It can't type special keys, so `:exe "norm A!\<Esc>"`.

[click] `:so` — source a file: each line is an Ex command. Normal Vimscript.

[click] `:so!` — the key idea of the whole talk. The `!` feeds the file into typeahead, keystroke by keystroke, starting in Normal mode. A newline is pressing Enter. Every solution tonight runs this way; `nvim -s` does the same at startup.
-->

---

# Ex Commands

<div class="ex-sub">Almost every Ex command takes an optional <b class="c-range">range</b></div>

<div class="ex-grid">
<div class="ex-head">range</div><div class="ex-head">what it does</div>

<div v-click="1" class="ex-cmd">:<span class="c-cmd">s</span></div>
<div v-click="1" class="ex-desc">current line</div>

<div v-click="2" class="ex-cmd">:<span class="c-range">1</span><span class="c-cmd">s</span></div>
<div v-click="2" class="ex-desc">line 1</div>

<div v-click="3" class="ex-cmd">:<span class="c-range">%</span><span class="c-cmd">s</span></div>
<div v-click="3" class="ex-desc">every line</div>

<div v-click="4" class="ex-cmd">:<span class="c-range">2,$-2</span><span class="c-cmd">s</span></div>
<div v-click="4" class="ex-desc">line 2 through the third-to-last</div>

<div v-click="5" class="ex-cmd">:<span class="c-range">,$-2</span><span class="c-cmd">g</span></div>
<div v-click="5" class="ex-desc">current line through the third-to-last</div>

<div v-click="6" class="ex-cmd">:<span class="c-range">/pat/</span><span class="c-cmd">s</span></div>
<div v-click="6" class="ex-desc">the next line matching <code>pat</code></div>
</div>

---

# Registers

<div class="ex-grid">
<div class="ex-head">name</div><div class="ex-head">what it holds</div>

<div v-click="1" class="ex-cmd"><span class="ex-sep">&quot;</span><span class="c-reg">&quot;</span></div>
<div v-click="1" class="ex-desc"><b>unnamed</b> — whatever you last yanked or deleted</div>

<div v-click="2" class="ex-cmd"><span class="ex-sep">&quot;</span><span class="c-reg">a</span>–<span class="c-reg">z</span><br><span class="ex-sep">&quot;</span><span class="c-reg">0</span>–<span class="c-reg">9</span></div>
<div v-click="2" class="ex-desc"><b>named</b> — 26 that are yours<div class="ex-note-static">plus 10 numbered ones Vim fills with your recent yanks &amp; deletes</div></div>

<div v-click="3" class="ex-cmd ex-cmd-sm"><span class="c-reg">-</span><span class="c-reg">:</span><span class="c-reg">.</span><span class="c-reg">%</span><span class="c-reg">#</span><span class="c-reg">=</span><span class="c-reg">*</span><span class="c-reg">+</span><span class="c-reg">_</span><span class="c-reg">/</span></div>
<div v-click="3" class="ex-desc"><b>special</b> — last command, last search, last insert, the file name, the system clipboard, a black hole…</div>
</div>

<!--
All editors have a clipboard. Vim has 47.

[click] `""` — the unnamed register. Every yank and delete lands here; plain `p` pastes it.

[click] `"a`–`"z` — yours. `"ayy` yanks into a, `"ap` pastes it. Uppercase `"A` *appends*. `"0`–`"9` Vim fills for you: `"0` is the last yank, `"1`–`"9` a history of deletes.

[click] The specials: `"-` small delete, `":` last command, `".` last insert, `"%` file name, `"#` alternate file, `"=` expression, `"*` `"+` system clipboards, `"_` black hole, `"/` last search.

And the mental shift for later: registers aren't a clipboard, they're string variables. `qa…q` records into a, `@a` *types its contents*. So `:let @q = 'yyp'` writes a macro as a string. taxes2.vim builds shell commands as text, deletes them into `t`, and runs `norm @t`.
-->

---
clicks: 5
---

# Recursive Macros

<div class="rm-wrap">
<div class="rm-expr">
<span v-for="(p, i) in ['qqq', 'qq', '@q', 'q', '@q']" :key="i"
  class="rm-part" :class="{ 'rm-cur': $clicks === i + 1, 'rm-dim': $clicks > 0 && $clicks !== i + 1 }">{{ p }}</span>

<div v-for="(c, i) in [
    { x: 1.5, text: 'clear <code>q</code> register' },
    { x: 4,   text: 'record to <code>q</code> register' },
    { x: 6,   text: 'recursive call' },
    { x: 7.5, text: 'stop recording' },
    { x: 9,   text: 'start the macro' },
  ]" :key="'c' + i"
  class="rm-anchor" :style="{ left: c.x + 'ch' }" v-show="$clicks > i">
<div class="rm-line" :style="{ height: (1.6 + i * 2.4) + 'rem' }" />
<div class="rm-caption" :class="{ 'rm-cap-cur': $clicks === i + 1 }"
  :style="{ top: (1.6 + i * 2.4) + 'rem' }" v-html="c.text" />
</div>
</div>
</div>

<style>
.rm-wrap { display: flex; justify-content: center; margin-top: 3.5rem; }
.rm-expr { position: relative; font-family: var(--slidev-code-font-family, monospace); font-size: 4.5rem; line-height: 1; height: 16rem; }
.rm-part { font-weight: 300; transition: all .25s; }
.rm-part.rm-dim { opacity: .45; }
.rm-part.rm-cur { font-weight: 800; color: var(--slidev-theme-primary, #5d8392); }
.rm-anchor { position: absolute; top: 4.9rem; width: 0; }
.rm-line { width: 2px; margin-left: -1px; background: currentColor; opacity: .5; }
.rm-line::after { content: ''; position: absolute; left: -4px; width: 8px; height: 8px; margin-top: -4px; border-radius: 50%; background: currentColor; top: 100%; }
.rm-anchor .rm-line { position: relative; }
.rm-caption { position: absolute; right: .9rem; transform: translateY(-50%); white-space: nowrap; font-family: var(--slidev-font-family, sans-serif); font-size: 1.5rem; line-height: 1.2; opacity: .6; transition: opacity .25s; }
.rm-caption.rm-cap-cur { opacity: 1; font-weight: 600; }
</style>

<!--
This is `qqqqq@qq@q` from the abstract.

[click] `qqq`: record nothing into q. Without this, the `@q` during recording would run whatever *old* macro was in q. Fun.

[click] `qq`: start recording into q. Whatever you do now (the body) runs once, live.

[click] `@q`: call q… which is empty right now, so it's a no-op — but it gets *recorded*.

[click] `q`: stop. q now ends by calling itself.

[click] `@q`: go. Forever — until something fails.
-->

---

# The Control Character Zoo

<div class="ex-grid">
<div class="ex-head">shown as</div><div class="ex-head">means</div>

<div v-click="1" class="ex-cmd"><span class="c-cmd">^M</span></div>
<div v-click="1" class="ex-desc"><b>Enter</b></div>

<div v-click="2" class="ex-cmd"><span class="c-cmd">^[</span></div>
<div v-click="2" class="ex-desc"><b>Escape</b></div>

<div v-click="3" class="ex-cmd"><span class="c-cmd">^R</span></div>
<div v-click="3" class="ex-desc"><b>Ctrl-R</b>: insert a register</div>

<div v-click="4" class="ex-cmd"><span class="c-cmd">^R=</span></div>
<div v-click="4" class="ex-desc">insert the result of an <b>expression</b></div>

<div v-click="5" class="ex-cmd"><span class="c-cmd">^A<span class="ex-sep">/</span>^X</span></div>
<div v-click="5" class="ex-desc">increment / decrement a number</div>

<div v-click="6" class="ex-cmd"><span class="c-cmd">^V</span></div>
<div v-click="6" class="ex-desc">the next key is <b>text</b>, not a keypress</div>
</div>

<!--
Scripts tonight are full of these. `^M` is one byte, 0x0D: the Enter key.
-->

---

# Vimscript

```vim
let Double = {x -> x * 2}                " lambdas
'1 2 3'->split()->map({_, x -> x * 2})   " method chains
expand('<cword>')                        " the word under the cursor
v:statusmsg                              " the last message shown
input("Favorite color? ")                " ask the user
eval(getline(1))                         " run text as an expression
while cond | … | endw                    " loops, as a one-liner
try | … | cat | … | endt                 " try/catch, as a one-liner
sil! …                                   " do it *silently*
```

<!--
`eval()` takes a string and runs it as a Vimscript expression — server.vim reads mimes.txt (a dictionary literal, written out as text) and just `eval()`s it into a real dictionary.

`:while` — loop until the condition is false. Like everything else it fits on one line with `|`. The brainfuck compiler turns every `[...]` into `:while expand('<cword>') != 0 | exe 'norm …' | endw`: keep going while the number under the cursor isn't zero.

try/catch: server.vim wraps `gf` in one, so a missing file opens the 404 page instead.

`:sil!` — run it and swallow any errors.
-->
---
layout: center
---

# The Game

```bash
nvim --headless -n -u NONE -i NONE -s solution.vim input.txt
```

<v-clicks>

- `-u NONE` — no config, no plugins, no mercy
- `-s` — `:so!` at startup: the script is **keystrokes**, Vim "types" it for you
- whatever's left in the buffer is the answer

</v-clicks>

<!--
The important bit: `-s` replays a file as if I typed it. So a solution is literally a recording of someone using Vim very, very weirdly.

Every output you see in these slides was produced by actually running the script at build time — no faking.
-->

---
layout: script
---

# Trapping Rain Water

Given bar heights, how much water pools between them?

```vim-run
script: ../sol1.vim
show: script
attrs: {all|all|1,5|2|3|4|6|7|all}
```

::input::

```vim-run
script: ../sol1.vim
input: ../input1.txt
show: input
```

::output::

```vim-run
script: ../sol1.vim
input: ../input1.txt
show: output
```

<!--
Input and output are up first. Click to hide them, then step through line by line:

1. `qqq` clears register q, `qq` starts recording it. `yyp$` duplicates the heights line.
2. Decrement every number on line 1.
3–4. If line 2 still has a positive number, turn it into a row of `x` (wall) and ` ` (air).
5. `k@q` — the macro calls itself, so it keeps stacking rows until the search on line 3 fails. That failure is the loop's exit condition.
6. Now the buffer is an ASCII-art skyline. Count spaces with an `x` on both sides, using `n` so nothing gets replaced: "9 matches".
7. And then the cursed part: replace the whole buffer with `v:statusmsg + 0`. "9 matches" + 0 = 9.

And the output you saw at the start: 9. Correct!
-->

---
layout: script
inputLabel: before
outputLabel: after
---

# Conway's Game of Life

One generation per run

```vim-run
script: ../life.vim
show: script
attrs: {all|all|2-3|4|5|all}
```

::input::

```vim-run
script: ../life.vim
input: ../life.txt
show: input
```

::output::

```vim-run
script: ../life.vim
input: ../life.txt
show: output
```

---
layout: script
---

# Brainf*ck Interpreter

Compilation to normal-mode keystrokes with search and replace

```vim-run
script: ../brainfuck.vim
show: script
attrs: {all|all|2-9|10-12|13-|all}{maxHeight:'330px'}
```

::input::

```vim-run
script: ../brainfuck.vim
input: inputs/hello.bf
show: input
```

::output::

```vim-run
script: ../brainfuck.vim
input: inputs/hello.bf
show: output
```

<!--
Hello world, compiled and run by Vim. Takes about a second, which, honestly, is faster than some CI pipelines I've used.

[click] The trick: don't *interpret* brainfuck. Translate it into Vim keystrokes and let Vim execute that.

- `>` becomes `w`, `<` becomes `ge` — the tape is a line of 1000 words, "0 0 0 0…"
- `+` / `-` become Ctrl-A / Ctrl-X, then the @w macro wraps the result mod 256
- `.` appends nr2char(<cword>) to register o
- loops `[...]` become `:while expand('<cword>') != 0 | exe 'norm …' | endwhile` — built innermost-first by a recursive macro
- finally, build the tape, run register a, and replace the buffer with register o
-->

---
layout: default
transition: none
---

# Conclusions

<v-clicks>

- Vim is *absurdly* powerful
- …but it's still a text editor
- every tool has its limits
- use the right tool for the job

</v-clicks>

<!--
Play it totally straight. This should look like the end of the talk.

[click ×4, slow]

"yk, every tool has their limit, vim included. I mean, it's not like vim will do your taxes or anything..."

Beat. Then click — this slide has `transition: none`, so the next one is a HARD CUT. Do not smile before the cut.
-->

---
layout: cover
background: /f1040.jpg
class: text-center
---

<div class="inline-block mt-28 px-12 py-8 rounded-xl bg-black/75 backdrop-blur-sm shadow-2xl">

# Doing My Taxes in Neovim

<div class="opacity-70 text-sm tracking-widest uppercase mt-4">a live demo</div>

</div>

<style>
.slidev-layout { background-position: top !important; }
h1 { font-weight: 700 !important; }
</style>

---

# IRS-Approved Tax Script

```vim-run
script: ../taxes2.vim
show: script
attrs: {all}{maxHeight:'380px'}
```

<!--
Click through:
- 1–5: the 2025 standard deductions and tax brackets, hard-coded (we do NOT check the tax table. scandalous.). `Tax` adds up each bracket's rate *bump* times how far you're past it — one lambda.
- 7–8: Sum / Show lambdas for money
- 9–14: a table of prompts — condition, variable, prompt, validation regex, error message, transform
- 16: every "your" row gets duplicated into a "your spouse's" row, conditioned on `married`
- 17–36: from here on, everything is *typed into the buffer as text*. First: the 1040, line by line — `line_15` is taxable income, `line_16` the tax, `line_34` the refund, `line_37` what you owe
- 37–71: an FDF file (the PDF form-fill format) full of Ctrl-R = inserts
- 72–76: curl the form from irs.gov, pdftk fill_form, xdg-open
- 77–78: …and then all that text gets deleted into register t. It's a macro now.
- 79–81: the table is regex'd into Vimscript (input() + validation loops), joined into ONE Ex command ending in `norm @t`, and executed with @"

The script writes the rest of the script.
-->

---

# Web Server

```vim-run
script: ../server.sh
lang: bash
show: script
attrs: {all|19|all}
```

<!--
"So, these slides need to be served from somewhere…"

- nftables rate limiting, because every request spawns a whole Neovim
- generate the MIME table if it's missing (next-next slide)
- ncat listens on 8080 and, for each connection, pipes the socket into… `nvim -s server.vim`
-->

---

# Web Server

```vim-run
script: ../server.vim
show: script
attrs: {all}{maxHeight:'380px'}
```

<!--
One Neovim process per HTTP request.

1–3. binary mode, a "write to stdout and quit" macro, and a 408 macro
4–6. read the request headers off the socket, then Content-Length bytes of body
7–9. HEAD → GET (and remember to drop the body), BREW → 418 I'm a teapot, anything else → 405
10–16. path sanitising: absolute URIs, `..`, `~`, `$`, `/` → index.html, directories → index.html
17. `gf` — open the file under the cursor. If it doesn't exist, catch → 404 page
18–21. status line, look up the MIME type
22–27. type the response headers above the file, write the whole buffer to stdout, :qa!
-->

---

# Web Server

Scraping MDN's MIME table into a Vim dictionary

```vim-run
script: ../mimes.vim
show: script
attrs: {all}
```

<!--
curl the MDN "Common MIME types" page, delete everything that isn't the table, regex the HTML table into `'ext':'type',` pairs, join, wrap in braces, :x mimes.txt.

server.vim then just `eval()`s the file. Totally safe. Definitely.
-->

---
layout: fact
---

# One more thing...

<v-clicks>

## You're looking at it

These slides are being served by Vim, **right now**.

</v-clicks>

<!--
PAUSE. Ctrl-I in the browser — show them the user agent.

Fun numbers:
- first page load = ~98 requests = ~98 Neovim processes
- every single one of them quit Vim successfully, which is more than most of us can say
-->

---
layout: end
---

# :wq

thanks!

<!--
Questions? (Answers will be provided as a Vim macro.)
-->
