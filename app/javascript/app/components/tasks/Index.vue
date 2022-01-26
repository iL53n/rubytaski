<template lang="pug">
    div(class="q-pa-md")
      div(align="left")
      q-card(class="col-2 q-ma-lg")
        q-card-section(class="row")
          div(class="col text-h3 text-blue-grey-14" align="left") {{ $t('tasks.title') }}
          q-banner(v-if="bannerShow" inline-actions rounded class="bg-green-1")
            template(v-slot:avatar)
              q-icon(name="import_export" color="green-2")
            .text-subtitle1.text-green-6 Вы изменили сортировку задач! Хотите сохранить (для всех видов)?
            template(v-slot:action)
              q-btn(@click="updateTasksOrder()" flat round color="green-7" icon="check")
              q-btn(@click="getTasks()" flat round color="red-7" icon="close")
          div(class="col text-subtitle1 text-grey" align="right")
            br
            q-btn(unelevated rounded no-caps color="deep-purple-1" text-color="primary" @click="newTask()" icon="add" name="new_task" label="Add Task")
        q-card-section
          q-markup-table(
            ref="table"
            row-key="id"
            separator="cell"
            class="no-shadow")
            thead
              tr
                th(class="text-center") 
                //- th(class="text-left") ID
                th(class="text-left") #
                th(class="text-left") Title
                th(class="text-left") Description
                th(class="text-left") Actions
            //- https://codepen.io/kabanoki/pen/WXBKGY
            draggable(
              v-model="taskList.table.data"
              @end="setTasksOrder"
              class="dragArea"
              tag="tbody"
              :options="{animation:300, handle:'.handle'}"
              )
              tr(v-for="el in taskList.table.data" :key="el.id")
                td
                  q-icon(name="dehaze" class="handle text-grey" size="xs")
                //- td {{ el.id }}
                td {{ el.order + 1 }}
                td {{ el.title }} 
                td {{ el.description }}
                td(key="actions") 
                  actions-cell(
                    :actions="el.actions",
                    :title="el.title",
                    :id="el.id"
                    @refresh="getTasks()")
      router-view(@refresh="getTasks()")
</template>

<script>
  import NewTask from 'components/tasks/New'
  import actionsCell from 'components/tasks/ActionsCell'
  import LoadingMixin from 'mixins'
  import draggable from "vuedraggable";

  export default {
    data() {
      return {
        taskList: {
          table: {
          columns: [],
          data: []
          }
        },
        order: {},
        bannerShow: false
      }
    },
    created () {
      this.getTasks()
    },
    computed: {},
    methods: {
      setTasksOrder() {
        var data = this.taskList.table.data
        // this.order = data.map(function(task, index) {
        //   return { id: task.id, order: index }
        // })
        this.order = data.reduce(function(map, obj, index) {
            map[obj.id] = index;
            return map;
        }, {});
        this.bannerShow = true
      },
      updateTasksOrder() {
        this.$backend.tasks.update_order(this.order)
          .then((response) => {
            console.log("Order updated!")
          })
          .catch(()   => this.error = true)
          .finally(() => {
            this.getTasks()
          })
      },
      getTasks() {
        this.$backend.tasks.index()
          .then((response) => {
            this.taskList = response.data
          })
          .catch(()   => this.error = true)
          .finally(() => {
            this.loading = false
            this.bannerShow = false
          })
      },
      newTask() {
        this.$router.push({ name: 'newTask' })
      },
    },
    components: {
      NewTask,  
      actionsCell,
      draggable
    },
    mixins: [
      LoadingMixin
    ]
  };
</script>

<style scoped>
  .handle {
    cursor: move;
  }
  .sortable-chosen {
    opacity: 0.7;
    background-color:#dcdcdc;
  }
  .sortable-ghost {
    background-color:#dcdcdc;
  }
</style>
