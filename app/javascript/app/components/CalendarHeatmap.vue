<template lang="pug">
  div(class="q-pa-md row justify-around")
    //- https://www.color-hex.com/color/6544d3
    calendar-heatmap(
      :values="data"
      :vertical="true"
      tooltip-unit="stars"
      :end-date="last_months_day"
      :range-color="['#eceef0','#9ceaaa','#3ec563','#2ca24d','#1b6e36']"
      )
</template>

<script>
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
        this.$backend.statistics.index()
          .then((response) => {
            this.data = response.data
            this.getTasks()
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      getLastMonthsDay() {
        this.last_months_day = new Date(this.current_date.getFullYear(), this.current_date.getMonth() + 1, 0);
      }  
    }
  }
</script>

<style scoped></style>