<template lang="pug">
  div
    q-calendar(
      v-model="selectedDate"
      view="week-scheduler"
      :resources="resources"
      locale="ru"
      style="height: 100%;"
    )
      template(#scheduler-resource-day="{ timestamp, /* index, */ resource }")
        q-btn(flat class="fit")
          span(class="ellipsis" style="font-size: 10px;") {{ resource.label }}:{{ timestamp.day }}
    div {{ this.tasks }}
</template>

<script>
  import { getTasks } from '../api'

  export default {
    data () {
      return {
        tasks: this.getTasks(),
        selectedDate: '',
        resources: [
          { label: 'Застелить кровать' },
          { label: 'Сделать зарядку' },
          { label: 'Помочь маме' },
          { label: 'Убрать рабочий стол' },
          { label: 'Позаниматься англ.яз' },
          { label: 'Сделать ДЗ' },
          { label: 'Почиатать перед сном' }
        ]
      }
    },
    methods: {
      getTasks() {
        getTasks()
          .then((response) => {
            console.log(response.data)
            this.tasks = response.data
        })
      },
    },
    components: {}
  }
</script>