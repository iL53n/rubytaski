<template lang="pug">
  .q-pa-xl.row.items-start.justify-around.q-gutter-xl
    q-card.my-card
      q-img(src="https://coolhdwall.com/storage/202101/astronaut-floating-space-2k-wallpaper-3840x1600.jpg")
        .absolute-bottom.text-right.text-h3 rubytaski
      q-card-section
        div(class="text-h5 text-left") We do what we love and
        div(class="text-h5 text-left") we love what we do
        div(class="text-subtitle1 text-left text-blue-grey-14")
          | We love to create tools for improving Kids' and Teens' life,
          | because in this way we improve the future, we change it.
        br
        br
        div(class="text-body2 text-grey")
          | To learn more about the team, or have any questions,
          | you're more than welcome to contact us at <a href = "mailto: hello@rubytaski.com">hello@rubytaski.com</a>.
      q-card-section.text-caption.text-grey © {{currentYear}} RubyTaski team
</template>

<script>

export default {
  data () {
    return {
    }
  },
  computed: {
    currentYear() {
      return new Date().getFullYear()
    },

  },
  created() {
  },
  methods: {

  },
  components: {
  }
}
</script>

<style  scoped>
.my-card {
  width: 100%;
  max-width: 600px
  }
</style>

