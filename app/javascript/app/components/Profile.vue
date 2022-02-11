<template lang="pug">
  div(class="q-pa-xl row items-start q-gutter-xl")
    q-card(class="col-4" align="left")
      q-item
        q-item-section(avatar)
          q-avatar(size="80px")
            img(src="https://cdn.quasar.dev/img/boy-avatar.png")

        q-item-section
          q-item-label(class="text-h5") Bogdan Gribko
          q-item-label(caption) Registered: 2021-02-21
      q-separator
      q-card-section
        q-card-section(class="text-subtitle1") Personal info
        p Email
        p Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    q-card(class="col")
      q-item
        q-item-section(avatar)
          q-icon(class="text-primary bg-deep-purple-1 profile-icon" name="settings")
        q-item-section(class="text-blue-grey-8" align="left")
          q-item-label(class="text-subtitle1") {{ $t('menu.top.profile.my_config') }}
          q-item-label(caption) {{ $t('menu.top.profile.my_config_description') }}
      q-separator
      q-card-section(horizontal)
        q-card-section Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        q-separator(vertical)
        q-card-section(class="col-4") col4Lorem ipsum dolor sit amet, consectetur adipiscing elit.

</template>

<script>

  export default {
    data () {
      return {

      } 
    },
    created() {

    },
    methods: {

    },
    components: {

    }
  }
</script>

<style scoped>
.profile-icon {
  border-radius: 5px;
  padding: 10px
}
</style>

