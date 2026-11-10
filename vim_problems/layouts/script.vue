<!--
  Script walkthrough: script on the left (~2/3), input over output on the right.

  Everything shows at first; the first click hides input/output (the script
  widens to fill the space) so you can step
  through the script's highlighted lines. Give the script's `attrs` a leading
  extra `all` so its first highlight step lands on click 2:

```md
---
layout: script
inputLabel: before      # optional, default "input"
outputLabel: after      # optional, default "output"
---

# Title

```vim-run
script: ../sol1.vim
show: script
attrs: {all|all|1|2|all}
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
```
-->

<script setup lang="ts">
import { computed } from 'vue'
import { useSlideContext } from '@slidev/client'

const props = withDefaults(defineProps<{
  inputLabel?: string
  outputLabel?: string
}>(), {
  inputLabel: 'input',
  outputLabel: 'output',
})

const { $clicks } = useSlideContext()
const hidden = computed(() => $clicks.value >= 1)
</script>

<template>
  <div class="slidev-layout script-layout" :class="{ 'sl-wide': hidden }">
    <div class="sl-left">
      <slot />
    </div>
    <div class="sl-right" :class="{ 'sl-hidden': hidden }">
      <div class="sl-pane">
        <div class="sl-label">{{ props.inputLabel }}</div>
        <div class="sl-body"><slot name="input" /></div>
      </div>
      <div class="sl-pane">
        <div class="sl-label">{{ props.outputLabel }}</div>
        <div class="sl-body"><slot name="output" /></div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.script-layout {
  display: grid;
  grid-template-columns: 2fr 1fr;
  column-gap: 2rem;
  height: 100%;
  transition: grid-template-columns .5s ease, column-gap .5s ease;
}
/* input/output gone: the script column slides over to take the space */
.script-layout.sl-wide { grid-template-columns: 1fr 0fr; column-gap: 0; }
.sl-left { min-width: 0; overflow: hidden; }
.sl-right {
  display: grid;
  min-width: 0;
  overflow: hidden;
  grid-template-rows: 1fr 1fr;
  row-gap: 1rem;
  min-height: 0;
  padding-top: 4.5rem; /* clear the slide title */
  transition: opacity .35s ease;
}
.sl-right.sl-hidden { opacity: 0; pointer-events: none; }
.sl-pane { display: flex; flex-direction: column; min-height: 0; }
.sl-label {
  white-space: nowrap;
  font-size: .8rem; text-transform: uppercase; letter-spacing: .12em; opacity: .5;
  border-bottom: 1px solid currentColor; padding-bottom: .25rem; margin-bottom: .5rem;
}
.sl-body { flex: 1; min-height: 0; overflow: auto; }
.sl-body :deep(.slidev-code-wrapper) { margin: 0; }
/* long one-line inputs (e.g. brainfuck source) wrap instead of scrolling sideways */
.sl-body :deep(pre),
.sl-body :deep(code),
.sl-body :deep(.line) { white-space: pre-wrap !important; overflow-wrap: anywhere; word-break: break-all; }
</style>
