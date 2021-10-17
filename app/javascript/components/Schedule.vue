<template lang="pug">
  div
    q-page-container(align="middle")
      //q-toolbar(class="bg-green-3")
      //  q-toolbar-title(align="middle") #моянеделя
      div(class="q-pa-md row justify-around")
        q-card
          q-card-section
            q-calendar(
              v-model="selectedDate"
              view="week-scheduler"
              :resources="resources"
              resource-key="id"
              :resource-width="450"
              locale="ru"
              style="height: 100%;"
            )
              template(#scheduler-resource="{ resource /*, index */ }")
                div(class="col-12")
                  q-btn(flat class="fit" size="xl")
                    div(class="ellipsis") {{ resource.attributes.title }}
              template(#scheduler-resource-day="{ timestamp, /* index, */ resource }")
                //q-btn(flat class="fit")
                  //span(class="ellipsis" style="font-size: 10px;") {{ resource.attributes.title }}:{{ timestamp.day }}
                q-btn(flat class="fit")
                  //span(class="ellipsis" style="font-size: 10px;") {{ timestamp.date }}:{{ resource.attributes.stars_dates }}
                  div(v-for="star in resource.attributes.stars_dates" :key="star.id")
                    //div(v-if="star.due_date ==   timestamp.date")
                    //  | {{ timestamp.date }}
                    q-btn(
                      v-if="star.due_date == timestamp.date"
                      flat
                      round
                      padding="xs"
                      :ripple="{ color: 'blue' }"
                      align="around"
                      class="fit"
                      name="star"
                      text-color="yellow"
                      size="35px"
                      icon="star_border"
                      @click=""
                    )
</template>

<script>
  import { getTasks } from '../api'

  export default {
    data () {
      return {
        selectedDate: '',
        resources: this.getTasks(),
      }
    },
    methods: {
      getTasks() {
        getTasks()
          .then((response) => {
            console.log(response.data.data[0].attributes.stars_dates)
            this.resources = response.data.data
        })
      },
    },
    components: {}
  }
</script>