<template lang="pug">
  q-header(elevated)
    q-toolbar
      //q-btn(flat round dense icon="menu" class="q-mr-sm")
      q-avatar
      //img(src="https://cdn.quasar.dev/logo-v2/svg/logo-mono-white.svg")
      //q-toolbar-title(class="title") ChildSchedule
      div(id="square")
      q-toolbar-title rubytaski
      q-btn(flat round dense icon="menu")
</template>

<script></script>

<style scoped>
  /* .title {
    color: #fff200;
  } */
  #square {
    width: 18px;
    height: 18px;
    border-color: #fff200;
    border-style: solid;
    border-width: 3px
  }
</style>