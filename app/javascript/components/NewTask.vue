<template lang="pug">
  div
    q-card(style="width: 500px")
      q-form(enctype="multipart/form-data")
        q-card-section(class="q-gutter-y-md column")
          q-item-section
            q-input(
              filled
              ref="title"
              label="Задание *"
              placeholder="Наименование задания"
              v-model="task.title"
              type="text"
            )
            q-input(
              filled
              ref="title"
              label="Описание"
              placeholder="Описание задания"
              v-model="task.description"
              type="textarea"
            )
            q-btn(
              color="primary"
              label="Сохранить"
              @click="addTask"
              v-close-popup
            )
            q-btn(
              flat
              color="primary"
              label="Закрыть"
              v-close-popup
            )
</template>

<script>
  import { postTask } from '../api'

  export default {
    data: function () {
      return {
        task: {}
      }
    },
    methods: {
      addTask() {
        postTask(this.task)
          .then((response) => {
            this.$emit('add-task', this.task.title)
          })
      }
    }
  }
</script>

<style scoped></style>