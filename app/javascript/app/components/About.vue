<template lang="pug">
  .q-pa-xl.row.items-start.justify-around.q-gutter-xl
    q-card.my-card
      q-img(src="https://eufordigital.eu/wp-content/uploads/2019/08/georgia.jpg")
        .absolute-bottom.text-h6 RubyTaski
      q-card-section
        | Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
        | eiusmod tempor incididunt ut labore et dolore magna aliqua.
        | Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
        | eiusmod tempor incididunt ut labore et dolore magna aliqua.
        | Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
        | eiusmod tempor incididunt ut labore et dolore magna aliqua.
        | Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
        | eiusmod tempor incididunt ut labore et dolore magna aliqua.
        | Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
        | eiusmod tempor incididunt ut labore et dolore magna aliqua.
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
  max-width: 500px
  }
</style>

