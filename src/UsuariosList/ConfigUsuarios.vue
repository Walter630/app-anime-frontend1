<template>
  <v-app-bar flat height="250" class="pa-0" style="overflow: hidden">
    <v-img :src="imagemAleatoria" cover height="250">
      <v-container
        class="fill-height d-flex flex-column justify-end"
        style="background: rgba(0, 0, 0, 0.4)"
      >
        <!-- Botão no topo -->
        <v-btn
          class="ma-2"
          small
          color="primary"
          style="position: absolute; top: 10px; right: 10px"
        >
          Alterar capa
        </v-btn>

        <!-- Linha com avatar, nome e botão -->
        <v-row align="center" class="ma-2">
          <v-col cols="auto">
            <v-avatar size="100" image="/imgs/Nanatsu.jpg" />
          </v-col>
          <v-col>
            <div class="d-flex align-center">
              <h2 class="text-white mr-2">
                {{ todoStore.userLogado?.name || "Usuário não logado" }}
              </h2>
              <v-btn icon small>
                <v-icon class="text-white">mdi-pencil</v-icon>
              </v-btn>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </v-img>
  </v-app-bar>

  <v-container>
    <main style="margin-top: 240px">
      <v-row class="text-center">
        <v-menu>
          <template v-slot:activator="{ props }">
            <v-btn color="primary" dark v-bind="props" icon style="margin-top: 10px"
              ><v-icon>mdi-playlist-play</v-icon></v-btn
            >
          </template>
          <v-card>
            <v-col v-for="(episodios, nomeAnime) in episodiosAgrupados" :key="nomeAnime">
              <div><h2>Total de animes</h2></div>
              Anime: {{ nomeAnime }}
            </v-col>
          </v-card>
        </v-menu>
        <v-col>
          <v-icon>mdi-clock</v-icon>
          <div>Horas assistidas</div>
        </v-col>
        <v-col>
          <v-icon>mdi-heart</v-icon>
          <div>Favoritos</div>
        </v-col>
      </v-row>
      <br />
      <v-expansion-panels multiple>
        <v-expansion-panel
          v-for="(episodios, nomeAnime) in episodiosAgrupados"
          :key="nomeAnime"
        >
          <v-expansion-panel-title
            >{{ nomeAnime }} - {{ episodios.total }} episodios
            assistidos</v-expansion-panel-title
          >
          <v-expansion-panel-text>
            <v-divider></v-divider>
            <div v-for="(ep, index) in episodios.episodios" :key="index" class="mb-3">
              <v-divider></v-divider>
              Episódio {{ ep.episodios }}: {{ ep.title }}
            </div>
            <v-divider></v-divider>
          </v-expansion-panel-text>
        </v-expansion-panel>
      </v-expansion-panels>

      <!-- <v-list>
        <v-list-item v-for="atv in atividadesRecentes" :key="atv.id">
          <v-list-item-icon><v-icon>mdi-history</v-icon></v-list-item-icon>
          <v-list-item-content>{{ atv.texto }}</v-list-item-content>
        </v-list-item>
      </v-list> -->

      <v-btn class="btn" color="error" @click="sair">Sair</v-btn>
    </main>
  </v-container>
</template>

<script>
import { useTodoStore } from "@/stores/todoStore";
import { computed } from "vue";
import TodoLogin from "@/components/TodoLogin.vue";
import AnimeDetailsView from "../views/AnimeDetailsView.vue";
import { useRouter } from "vue-router";

export default {
  components: { TodoLogin, AnimeDetailsView },
  setup() {
    const todoStore = useTodoStore();
    const usuarios = todoStore.usuarios;
    const router = useRouter();

    const carrosel = ["/anime1.jpg", "/anime2.jpg", "/anime3.jpg"];
    const imagemAleatoria = carrosel[Math.floor(Math.random() * carrosel.length)];
    const useEdit = computed(() => {
      return todoStore.userLogado ? todoStore.userLogado : null;
    });

    const marcarComoAssistido = (ep) => {
      ep.assistido = true;
    };

    const sair = () => {
      router.push("home");
    };

    const episodiosAgrupados = computed(() => {
      const agrupado = {};

      for (const ep of todoStore.userLogado?.episodiosAssistidos || []) {
        if (!agrupado[ep.name]) {
          agrupado[ep.name] = {
            total: 0,
            episodios: [],
          };
        }

        agrupado[ep.name].total += 1;
        agrupado[ep.name].episodios.push(ep);
      }

      return agrupado;
    });

    return {
      usuarios,
      useEdit,
      todoStore,
      marcarComoAssistido,
      sair,
      episodiosAgrupados,
      imagemAleatoria,
    };
  },
};
</script>

<style>
.conta {
  background-color: rgba(85, 77, 77, 0.1);
}
.btn {
  color: red;
  transition: all 0.4s;
}
.btn:hover {
  background-color: black;
}

.tipos {
  display: flex;
  text-align: center;
}
.episodios {
  border-radius: 10px;
  width: 30rem;
}
</style>
