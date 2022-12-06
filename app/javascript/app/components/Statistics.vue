<template lang="pug">
  div
    //.text-h3.text-blue-grey-14 {{ $t('stat.title') }} DEMO
    top-widgets
    .row
      .col
        stars-date-count
      //.col
      //  tasks-streak
    //.row
    //  .col
    //    stars-task
    //  .col
    //    stars-wday
</template>

<script>
  import TopWidgets   from "components/statistics/TopWidgets";
  import StarsDateCount     from "components/statistics/Charts/StarsDateCount";
  import TasksStreak  from "components/statistics/Charts/TasksStreak";
  import StarsWday    from "components/statistics/Charts/StarsWday";
  import StarsTask    from "components/statistics/Charts/StarsTask";

  export default {
    data () {
      return {
        treemap: {
          options: {
            legend: {
              show: false
            },
            chart: {
              // height: 200,
              // width: 500,
              type: 'treemap'
            },
            title: {
              text: 'Tasks Treemap'
            }
          },
        },
        options: {
          chart: {
            id: 'vuechart-example'
          },
          xaxis: {
            categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998]
          }
        },
        series: [{
          name: 'demo_series',
          data: [30, 40, 15, 60, 80, 10, 90, 70]
        }]
      }
    },
    computed: {
      stat: {
        get() {
          return this.$store.state.statistics
        },
        set(value) {
          this.$store.commit('updateAllStatistics', value)
        }
      },
      efficiency() {
        return Math.round(this.stat.stars.all / (this.stat.tasks.all * this.stat.general.active_days) * 100)
      },
    },
    created() {
      // this.getStatistics()
    },
    methods: {
      // getStatistics() {
      //   this.$backend.statistics.index({ scopes: 'general_stat,tasks_stat,goals_stat,stars_stat,treemap_chart' })
      //     .then((response) => {
      //       this.stat = response.data.stat
      //     })
      //     .catch(()   => this.error = true)
      //     .finally(() => this.loading = false
      //     )
      // },
    },
    components: {
      TopWidgets,
      StarsDateCount,
      TasksStreak,
      StarsWday,
      StarsTask
    }
  }
</script>

<style scoped>
.zoom-box {
  transition: transform .4s; /* Animation */
}

.zoom-box:hover {
  transform: scale(1.05);
}
</style>

