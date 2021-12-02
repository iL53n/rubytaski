<template lang="pug">
  div(v-if="" class="q-pa-md")
    q-layout(view="lhh lpR lff" container style="height: 95vh" class="shadow-5 rounded-borders")
      header-component

      schedule

      footer-component
</template>

<script>
  import HeaderComponent from 'app/components/Header'
  import FooterComponent from 'app/components/Footer'
  import Schedule from 'app/components/Schedule'

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
