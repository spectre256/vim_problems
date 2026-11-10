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

---
clicks: 7
---

# Ex Commands

<div class="ex-grid ex-tight">
<div class="ex-head">command</div><div class="ex-head">what it does</div>

<div v-click="1" class="ex-cmd">:<span class="c-cmd">s</span><span class="c-body">/pat/rep/</span></div>
<div v-click="1" class="ex-desc">find &amp; replace with a regex</div>

<div v-click="2" class="ex-cmd">:<span class="c-cmd">g</span><span class="ex-grep c-body" :class="{ on: $clicks >= 3 }">/re/p</span></div>
<div v-click="2" class="ex-desc">run a command on every line that matches
<div class="ex-grep ex-note" :class="{ on: $clicks >= 3 }"><b>g</b>lobal / <b>re</b>gex / <b>p</b>rint</div>
</div>

<div v-click="4" class="ex-cmd">:<span class="c-cmd">norm</span></div>
<div v-click="4" class="ex-desc">type Normal-mode keys on each line</div>

<div v-click="5" class="ex-cmd">:<span class="c-cmd">so</span></div>
<div v-click="5" class="ex-desc">run a file as Ex commands</div>

<div v-click="6" class="ex-cmd">:<span class="c-cmd">so!</span></div>
<div v-click="6" class="ex-desc">replay a file <b>as if you typed it</b></div>

<div v-click="7" class="ex-cmd">:<span class="c-cmd">!</span><span class="c-body">cmd</span></div>
<div v-click="7" class="ex-desc">run a shell command</div>

<div v-click="7" class="ex-cmd">:<span class="c-cmd">w !</span><span class="c-body">cmd</span></div>
<div v-click="7" class="ex-desc">pipe the buffer into a command's <b>input</b></div>

<div v-click="7" class="ex-cmd">:<span class="c-cmd">r !</span><span class="c-body">cmd</span></div>
<div v-click="7" class="ex-desc">pipe a command's <b>output</b> into the buffer</div>
</div>

<style>
.ex-grep { display: inline-block; max-width: 0; opacity: 0; overflow: hidden; vertical-align: bottom; white-space: nowrap;
  transition: max-width .5s ease, opacity .5s ease; }
.ex-grep.on { max-width: 20rem; opacity: 1; }
.ex-note { display: block; max-width: none; max-height: 0; font-size: 1.1rem; color: inherit; opacity: 0; transition: max-height .5s, opacity .5s; }
.ex-note.on { max-height: 3rem; opacity: .75; }
.ex-tight { row-gap: .35rem; margin-top: 1rem; }
.ex-tight .ex-cmd { font-size: 1.75rem; }
</style>

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

---
layout: center
---

# The Game

```bash
nvim --headless -n -u NONE -i NONE -s solution.vim input.txt
```

<v-clicks>

- `-u NONE` — no config, no plugins
- `-s` — `:so!` at startup: the script is **keystrokes**, Vim "types" it for you
- whatever's left in the buffer is the answer

</v-clicks>

---

# Trapping Rain Water

<div class="rain-mm">

````md magic-move
```text
3 1 3 2 5 0 2 4
```
```text
3 1 3 2 5 0 2 4
3 1 3 2 5 0 2 4
```
```text
2 0 2 1 4 -1 1 3
3 1 3 2 5 0 2 4
```
```text
2 0 2 1 4 -1 1 3
xxxxx xx
```
```text
2 0 2 1 4 -1 1 3
2 0 2 1 4 -1 1 3
xxxxx xx
```
```text
1 -1 1 0 3 -2 0 2
2 0 2 1 4 -1 1 3
xxxxx xx
```
```text
1 -1 1 0 3 -2 0 2
x xxx xx
xxxxx xx
```
```text
1 -1 1 0 3 -2 0 2
1 -1 1 0 3 -2 0 2
x xxx xx
xxxxx xx
```
```text
0 -2 0 -1 2 -3 -1 1
1 -1 1 0 3 -2 0 2
x xxx xx
xxxxx xx
```
```text
0 -2 0 -1 2 -3 -1 1
x x x  x
x xxx xx
xxxxx xx
```
```text
0 -2 0 -1 2 -3 -1 1
0 -2 0 -1 2 -3 -1 1
x x x  x
x xxx xx
xxxxx xx
```
```text
-1 -3 -1 -2 1 -4 -2 0
0 -2 0 -1 2 -3 -1 1
x x x  x
x xxx xx
xxxxx xx
```
```text
-1 -3 -1 -2 1 -4 -2 0
    x  x
x x x  x
x xxx xx
xxxxx xx
```
```text
-1 -3 -1 -2 1 -4 -2 0
-1 -3 -1 -2 1 -4 -2 0
    x  x
x x x  x
x xxx xx
xxxxx xx
```
```text
-2 -4 -2 -3 0 -5 -3 -1
-1 -3 -1 -2 1 -4 -2 0
    x  x
x x x  x
x xxx xx
xxxxx xx
```
```text
-2 -4 -2 -3 0 -5 -3 -1
    x   
    x  x
x x x  x
x xxx xx
xxxxx xx
```
```text
-2 -4 -2 -3 0 -5 -3 -1
-2 -4 -2 -3 0 -5 -3 -1
    x   
    x  x
x x x  x
x xxx xx
xxxxx xx
```
```text
-3 -5 -3 -4 -1 -6 -4 -2
-2 -4 -2 -3 0 -5 -3 -1
    x   
    x  x
x x x  x
x xxx xx
xxxxx xx
```
```text
-3 -5 -3 -4 -1 -6 -4 -2
-2 -4 -2 -3 0 -5 -3 -1
    x   
    x~~x
x~x~x~~x
x~xxx~xx
xxxxx~xx
```
```text
9
```
````

</div>

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
attrs: {all|all|2-3|4-5|all}
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

---
layout: fact
---

# One more thing...

<v-clicks>

## You're looking at it

These slides are being served by Vim, **right now**.

</v-clicks>

---

# Web Server

```vim-run
script: ../server.sh
lang: bash
show: script
attrs: {all|19|all}
```

---

# Web Server

```vim-run
script: ../server.vim
show: script
attrs: {all}{maxHeight:'380px'}
```

---

# Web Server

Scraping MDN's MIME table into a Vim dictionary

```vim-run
script: ../mimes.vim
show: script
attrs: {all}
```

---
layout: end
---

# :wq

thanks!
