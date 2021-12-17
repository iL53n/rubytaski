// import iconSet from 'quasar/icon-set/fontawesome-v5.js'
// import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'
import iconSet from 'quasar/icon-set/material-icons'
import '@quasar/extras/material-icons/material-icons.css'
import '@quasar/extras/roboto-font/roboto-font.css'
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
  QDialog,
  QSeparator,
  QScrollArea,
  QItem,
  QItemSection,
  QIcon,
  QList,
  QChip,
  QBtnGroup,
  QRating,
  QKnob,
  QLinearProgress,
  QBadge,
  QImg,
  QMenu,
  QSlider,
  Notify,
  QSpace,
  ClosePopup,
  QBar,
  QSpinnerDots,
  QTable,
  QTd,
  QDate,
  QForm,
  QCardActions,
  QPopupProxy,
  date
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
    QDialog,
    QSeparator,
    QScrollArea,
    QItem,
    QItemSection, 
    QIcon,
    QList,
    QChip,
    QBtnGroup,
    QRating,
    QKnob,
    QLinearProgress,
    QBadge,
    QImg,
    QMenu,
    QSlider,
    QSpace,
    QBar,
    QSpinnerDots,
    QTable,
    QTd,
    QDate,
    QForm,
    QCardActions,
    QPopupProxy
  },
  directives: {
    ClosePopup
  },
  iconSet: iconSet,
  utils: {
    date
  },
  plugins: {
    Dialog,
    Notify
  },
}
