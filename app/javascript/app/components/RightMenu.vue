<template lang="pug">
  q-drawer(
    side="right"
    show-if-above
    mini-to-overlay
    :width="220"
    :breakpoint="500"
    )
    q-scroll-area(class="fit")
      q-list()
        q-item(class="bg-primary text-grey-1")
          q-item-section
            q-toolbar-title info info info info
        div(class="text-primary")
          q-item
</template>

<script></script>

<style scoped></style>