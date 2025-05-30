<template>
 <br>
  <v-window v-model="onboarding" show-arrows="hover" style="margin-top: 40px;">
    <v-window-item v-for="(image, n) in imageList" :key="`card-${n}`" >
      <v-card
        class="d-flex  align-center justify-center"
        elevation="4"
        height="450"
        color="black" dark
      >

         <v-img class=" img align-end " :src="image" cover>{{ todos[n]?.title }}</v-img>
      </v-card>
    </v-window-item>
  </v-window>
  <br><br>
  <v-card-title class="text-h4 title">
   <v-icon color="red">mdi-fire</v-icon> Animes em Alta <v-icon color="red">mdi-fire</v-icon>
  </v-card-title>
  <v-sheet
    class="mx-auto fundo"
    elevation="8"
    max-width="2000"

  >
    <v-slide-group
      v-model="model"
      class="pa-4"
      center-active
      show-arrows
    >
      <v-slide-group-item
        v-for="(todo, index) in todos"
        :key="index" :todo="todo"
        v-slot="{ isSelected, toggle }"
      >
        <v-card
          :color="isSelected ? 'primary' : 'black'"
          class="ma-1"
          height="280"
          width="190"
          @click="toggle"
          style="border-radius: 10px;"
        >
        <div class="d-flex flex-column flex-ms-row">
            <v-img
              class="images align-end "
              :src="todo.image ||  '/imgs/default.jpg'" 
              height="280"
              right="200"
              @click="goToAnime(todo.id)"
              style="cursor: pointer; "
              ></v-img> 
          </div>
          <div class="d-flex fill-height align-center justify-center">
            <v-scale-transition>
              <v-icon
                v-if="isSelected"
                color="white"
                icon="mdi-close-circle-outline"
                size="48"
              ></v-icon>
            </v-scale-transition>
          </div>
        </v-card>
      </v-slide-group-item>
    </v-slide-group>
  </v-sheet>

  <v-container fluid class="pa-0 image-overlay">
  <v-row no-gutters class="fill-height d-flex align-center justify-center text-center text-red">
    <v-col cols="12" md="6">
      <h1 class="text-h3 font-weight-bold mb-4">Gostou dos nossos conteúdos?</h1>
      <p class="text-subtitle-1">We know you'll love these</p>
    </v-col>
  </v-row>
</v-container>

<v-card-title class="text-h4 title">
   <v-icon color="red">mdi-fire</v-icon> Animes Magia <v-icon color="red">mdi-fire</v-icon>
</v-card-title>
<v-sheet
    class="mx-auto fundo"
    elevation="8"
    max-width="2000"
  >
    <v-slide-group
      v-model="model"
      class="pa-4"
      center-active
      show-arrows
    >
      <v-slide-group-item
        v-for="(todo, index) in filteredTodos"
        :key="index" :todo="todo"
        v-slot="{ isSelected, toggle }"
      >
        <v-card
          :color="isSelected ? 'primary' : 'black'"
          class="ma-1"
          height="280"
          width="190"
          @click="toggle"
          style="border-radius: 10px;"
        >
        <div class="d-flex flex-column flex-ms-row">
            <v-img
              class="images align-end "
              :src="`${todo.image}`"
              height="280"
              right="200"
              @click="goToAnime(todo.id)"
              style="cursor: pointer; "
              ></v-img> 
          </div>
          <div class="d-flex fill-height align-center justify-center">
            <v-scale-transition>
              <v-icon
                v-if="isSelected"
                color="white"
                icon="mdi-close-circle-outline"
                size="48"
              ></v-icon>
            </v-scale-transition>
          </div>
        </v-card>
      </v-slide-group-item>
    </v-slide-group>
  </v-sheet>

</template>

<script>
import { ref ,computed } from 'vue';
import { useTodoStore } from '@/stores/todoStore'
import { useRouter } from "vue-router";

export default {
  name: "TodoList",
  props: {
    todo: {
      type: Object,
      default: () => ({}),
    },
  },
  setup() {
    const todoStore = useTodoStore();
    const router = useRouter();
    const todos = todoStore.todos;
    
    
    const length = ref(4);
    const onboarding = ref(0);

    const imageList = ref([
        "/imgs/janela1.jpg", 
        "/imgs/janela2.jpeg", 
        "/imgs/janela3One.jpg", 
        "/imgs/janela4.jpg"
      ]);

    const show = ref(false)

    // Filtrando os animes da categoria 'romance'
    const filteredTodos = computed(() => {
      return todos.filter(todo => todo.categoria?.includes('magia'));
    });

    const toggleDone = (index) => {
      todoStore.commit(toggleDone(), index);
    };

    const removeTodo = (index) => {
      todoStore.commit(removeTodo(), index)
    };

    const goToAnime = (id) => {
      router.push({ name: "AnimeDetails", params: { id } });
    };

    return {
      toggleDone,
      removeTodo,
      goToAnime,
      show, 
      length,
      onboarding,
      imageList,
      todos,
      filteredTodos
    };
  },
};
</script>

<style scoped>
/* Aplicando transição suave na troca de imagem de fundo */
.images {
  transition: transform 0.3s ease-in-out;
}
.images:hover {
  transform: scale(1.08); /* aumenta 5% */
  cursor: pointer;
}
.img {
  width: 100%;
  max-width: 2000px; /* limita o tamanho em telas maiores */
  height: auto; /* mantém proporção da imagem */
  transition: transform 0.3s ease-in-out;
  box-shadow: 0px 4px 20px rgba(255, 255, 255, 0.3);
  border-radius: 8px;
  display: block;
  margin: 0 auto; /* centraliza em telas menores */
}

/* Responsividade extra para celulares */
@media (max-width: 600px) {
  .img {
    max-width: 100%;
    height: 180px;
    box-shadow: 0px 2px 10px rgba(255, 255, 255, 0.2);
  }
}

.img:hover{
  transform: scale(1.08); /* aumenta 5% */
  cursor: pointer;
  box-shadow: 0px 6px 25px rgba(255, 255, 255, 0.5); /* sombra mais forte no hover */
}
h2{
  color: white;
}
.title{
  color: white;
}
.fundo{
  background-color: rgba(15, 15, 15, 0.1);;
}
.hells-paradise {
  background-image: url('/imgs/hellsParadise.jpg');
  background-size: cover;
  background-position: end;
  min-height: 500px;
  box-shadow: 2px 6px 25px rgba(192, 0, 0, 0.836);
  border-radius: 8px;
}

.image-overlay {
  background-image: url('/imgs/hellsParadise.jpg');
  background-size: cover;
  background-position: end;
  min-height: 500px;
  box-shadow: 2px 6px 25px rgba(192, 0, 0, 0.836);
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  transition: transform 0.3s ease-in-out;
}
.image-overlay:hover {
  transform: scale(1.05);
  cursor: pointer;
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7));
  z-index: 1;
}


</style>