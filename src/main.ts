import          "./app.css"   ;
import App from "./App.svelte";
import MainLayout from "./ui/MainLayout.svelte";

const  app
= new  App({ target: document.getElementById("app")!, });

export       default                          app       ;

// const app = new MainLayout({
//     target: document.getElementById("app")!,
// })
// export default app;
