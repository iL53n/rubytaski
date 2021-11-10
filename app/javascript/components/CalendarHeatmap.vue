<template lang="pug">
  div(class="q-pa-md row justify-around")
    q-card(class="my-card")
      q-card-section
        calendar-heatmap(
          :values="data"
          tooltip-unit="stars"
          :end-date="last_months_day" 
          )
</template>

<script>
  import { getStatistics } from '../api'

  export default {
    // props: ['values'],
    data () {
      return {
        data: [],
        last_months_day: {},
        current_date: new Date()
      }
    },
    created() {
      this.getStatistics(),
      this.getLastMonthsDay()
    },
    methods: {
      getStatistics() {
        getStatistics()
          .then((response) => {
            this.data = response.data
        })
      },
      getLastMonthsDay() {
        this.last_months_day = new Date(this.current_date.getFullYear(), this.current_date.getMonth() + 1, 0);
      }  
    }
  }
</script>

<style lang="sass" scoped>
  .my-card {
    width: 80%;
    max-width: 1135px;
    // height: 10%;
    // max-height: 100px
  }
</style>