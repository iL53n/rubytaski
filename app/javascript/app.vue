<template lang="pug">
  div(v-if="" class="q-pa-md")
    q-layout(view="lhh lpR lff" container style="height: 95vh" class="shadow-5 rounded-borders")
      header-component

      schedule

      footer-component
</template>

<script>
  import HeaderComponent from 'components/Header'
  import FooterComponent from 'components/Footer'
  import Schedule from 'components/Schedule'

  export default {
    data () {
      return {
      }
    },
    components: {
      HeaderComponent,
      FooterComponent,
      Schedule
    }
  }
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
