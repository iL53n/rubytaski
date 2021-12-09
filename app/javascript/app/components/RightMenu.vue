<template lang="pug">
  q-drawer(show-if-above side="right" :width="300" :breakpoint="500")
    q-scroll-area(class="fit")
      q-list()
        q-item(style="background: rgb(248, 247, 253)" class="text-primary")
          q-icon(size="md" name="insert_chart_outlined")
          q-toolbar-title My statistics
          q-separator
        div(class="q-pa-sm")
          div(v-for="n in 15" :key="n")
            q-item Info {{ n }} / 15 
</template>

<script></script>

<style scoped></style>