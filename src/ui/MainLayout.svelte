<script lang="ts">
    import Header from "./Header.svelte";
    import Footer from "./Footer.svelte";
    import TopBar from "./TopBar.svelte";
    import SideBar from "./SideBar.svelte";
    import Canvas from "./Canvas.svelte";

    import { createClient } from '@supabase/supabase-js'
    const supabase = createClient(import.meta.env.VITE_SUPABASE_URL, import.meta.env.VITE_SUPABASE_KEY_PUB);

    const {data}=supabase.storage.from("noise_textures").getPublicUrl("sbs_-_noise_texture_pack_-_128x128/128x128/Cracks/Cracks 10 - 128x128.png")

    import type { GLSLUniformValue, GLSLUniforms,} from "../types";

    // Example uniforms
    let uniforms: GLSLUniforms = {
        uTime: 1.0,
        uBool: true,
        uResolution: [800, 600],
        uMouse: [0.5, 0.5],
        uTransform: [1, 0, 0, 0, 1, 0, 0, 0, 1], // mat3 example
        uSampler: data.publicUrl,
        uIntensity: 5, // int
        uColor: [1.0, 0.5, 0.2, 1.0], // vec4
    };

    // Handle updates to uniforms
    const handleUpdate = (updatedUniforms: GLSLUniforms): void => {
        uniforms = updatedUniforms;
        console.log("Updated uniforms:", uniforms);
    };
</script>
<main>
    <div class="container">
        <div class="headerContainer">
            <Header/>
        </div>
        <div class="topBarContainer">
            <TopBar/>
        </div>
        <div class="mainContainer">
            <div class="sideBarContainer">
                <SideBar uniforms={uniforms} onUpdate={handleUpdate}/>
            </div>
            <div class="canvasContainer">
                <Canvas
                    data={data}/>
            </div>
        </div>
        <div class="footerContainer">
            <Footer/>
        </div>
    </div>
</main>
<style>
    .container {
        width: 100vw;
        height: 100vh;
        position: relative;
        display: flex;
        flex-direction: column;
    }
    .headerContainer {
        width: 100%;
    }
    .footerContainer {
        width: 100%;
    }
    .topBarContainer {
        width: 100%;
    }
    .mainContainer {
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: row;
    }
    .sideBarContainer {
        width: 30%;
        height: 100%;
        overflow-x: scroll;
    }
    .canvasContainer {
        width: 70%;
        height: 100%;
    }
</style>