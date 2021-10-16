<template lang="pug">
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
</template>

<script>
  export default {
    data () {
      return {
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
    components: {}
  }
</script>