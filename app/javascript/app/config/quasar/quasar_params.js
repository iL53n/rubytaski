// import iconSet from 'quasar/icon-set/fontawesome-v5.js'
// import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'
import iconSet from 'quasar/icon-set/material-icons'
import '@quasar/extras/material-icons/material-icons.css'
import '../../assets/styles/quasar.styl'
import 'quasar/dist/quasar.ie.polyfills'
import {
  Dialog,
  QLayout,
  QHeader,
  QDrawer,
  QPageContainer,
  QPage,
  QBtn,
  QFooter,
  QToolbar,
  QToolbarTitle,
  QAvatar,
  QCard,
  QCardSection,
  QInput,
  QDialog
} from 'quasar'

export default {
  config: {},
  components: {
    QLayout,
    QHeader,
    QDrawer,
    QPageContainer,
    QPage,
    QBtn,
    QFooter,
    QToolbar,
    QToolbarTitle,
    QAvatar,
    QCard,
    QCardSection,
    QInput,
    QDialog
  },
  directives: {
  },
  iconSet: iconSet,
  plugins: {
    Dialog
  }
}
