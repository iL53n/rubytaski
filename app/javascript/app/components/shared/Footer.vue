<template lang="pug">
  q-footer(bordered class="bg-grey-3 text-primary")
    q-card-actions(align="around")
      q-btn(to="/dashboard" flat dense color="primary" size="xl" icon="dashboard")
      q-btn(to="/tasks_list" flat dense color="primary" size="xl" icon="library_add_check")
      q-btn(to="/goals_list" flat dense color="primary" size="xl" icon="flag_circle")
      q-btn(to="/my_statistics" flat dense color="primary" size="xl" icon="insert_chart")
</template>

<script>
export default {
  data () {
    return {

    }
  },
  computed: {
  },
  created () {
  },
  methods: {
  },
  components: {
  },
}
</script>

<style scoped>
</style>
