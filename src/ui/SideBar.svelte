<script lang="ts">
    import "beercss";
    import "material-dynamic-colors";
    import type { GLSLUniformValue, GLSLUniforms } from "../types";
    import {onMount} from "svelte";
    import { createClient, SupabaseClient } from '@supabase/supabase-js'

    export let uniforms:                   GLSLUniforms  =  {  };
    export let onUpdate: (updatedUniforms: GLSLUniforms) => void;

    type TextureForShader = {
        name: string,
        path: string,
    }

    const fetchAllTextures_BayerMatrix = (): TextureForShader[] => {
        let ns: number[] = [2,4,8,16];
        let result: TextureForShader[] = [];
        ns.forEach(n1 => {
        result.push(
            {
            name: `bayer${n1}.png`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}.png`,
            }
        );
        ns.forEach(n2 => {
            result.push(
            {
                name: `bayer${n1}tile${n2}.png`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/bayer_matrix_textures/tromero/bayer${n1}tile${n2}.png`,
            }
            );
        });
        });
        return result;
    }

    const fetchAllTextures_Noise = (): TextureForShader[] => {
        let pathsA: {path1: string, path2: string}[] = [
        {path1: "sbs_-_noise_texture_pack_-_128x128", path2: "128x128"},
        {path1: "sbs_-_noise_texture_pack_-_256x256", path2: "256x256"},
        {path1: "sbs_-_noise_texture_pack_-_512x512", path2: "512x512"},
        ];
        let pathsB: {path3: string, min: number, max: number}[] = [
        {path3: "Cracks"      , min: 1, max: 14},
        {path3: "Craters"     , min: 1, max: 14},
        {path3: "Gabor"       , min: 1, max: 14},
        {path3: "Grainy"      , min: 1, max: 14},
        {path3: "Manifold"    , min: 1, max: 14},
        {path3: "Marble"      , min: 1, max: 14},
        {path3: "Melt"        , min: 1, max: 14},
        {path3: "Milky"       , min: 1, max: 14},
        {path3: "Perlin"      , min: 1, max: 24},
        {path3: "Spokes"      , min: 1, max: 14},
        {path3: "Streak"      , min: 1, max: 14},
        {path3: "Super Noise" , min: 1, max: 14},
        {path3: "Super Perlin", min: 1, max: 14},
        {path3: "Swirl"       , min: 1, max: 14},
        {path3: "Techno"      , min: 1, max: 14},
        {path3: "Turbulence"  , min: 1, max: 14},
        {path3: "Vein"        , min: 1, max: 14},
        {path3: "Voronoi"     , min: 1, max: 14},
        ];
        let result:TextureForShader[] = [];
        for (let pathA of pathsA) {
        for (let pathB of pathsB) {
            for (let n = pathB.min; n <= pathB.max; ++n) {
            result.push(
                {
                name: `${pathB.path3} ${n} - ${pathA.path2}.png`,
                path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/noise_textures/${pathA.path1}/${pathA.path2}/${pathB.path3}/${pathB.path3} ${n} - ${pathA.path2}.png`,
                }
            );
            }
        }
        }
        return result;
    }

    const fetchAllTextures_Palette = async (supabase: SupabaseClient): Promise<TextureForShader[]> => {
        let {data,error} = await supabase.storage.from("palette_textures").list("lospec");
        let result: TextureForShader[] = [];
        for (let item of data ?? []) {
        result.push({
            name: `${item.name}`,
            path: `https://exuzuqkplqstsakskcrv.supabase.co/storage/v1/object/public/palette_textures/lospec/${item.name}`,
        });
        }
        return result;
    } 

    onMount(async () => {
        const supabase = createClient(import.meta.env.VITE_SUPABASE_URL
        , import.meta.env.VITE_SUPABASE_KEY_PUB);

        // let publicUrls = [];
        // for (let item of (await supabase.storage.from("noise_textures").list()).data ?? [])
        // {
            
        // }

        // let result = await supabase.storage.from("noise_textures").list("sbs_-_noise_texture_pack_-_128x128", {
        //   // limit: 100,
        //   // offset: 0,
        //   // sortBy: { column: 'name', order: 'asc' },
        // });
        // console.dir(result.data, { depth: null, colors: true })

        console.dir(await fetchAllTextures_Palette(supabase), { depth: null, colors: true })
    });

    const getType = (value: GLSLUniformValue): string => {
        if (Array.isArray(value)) {
        if (value.length ===  2) return "vec2";
        if (value.length ===  3) return "vec3";
        if (value.length ===  4) return "vec4";
        if (value.length ===  9) return "mat3";
        if (value.length === 16) return "mat4";
        }
        if (typeof value === "boolean") return "bool";
        if (typeof value === "number" && !Number.isInteger(value)) return "float";
        if (typeof value === "number" &&  Number.isInteger(value)) return       "int";
        if (typeof value === "string"                            ) return "sampler2D";
        return "unknown";
    };

  // Update uniforms when a value is changed
    const updateUniform = (
        key: string,
        index: number | null,
        newValue: number | boolean | string,
    ): void => {
        const updatedUniforms: GLSLUniforms = { ...uniforms };
        if (Array.isArray(updatedUniforms[key])) {
        if (index !== null)
            (updatedUniforms[key] as number[])[index] = newValue as number;
        } else {
        updatedUniforms[key] = newValue;
        }
        onUpdate?.(updatedUniforms); // Trigger callback
    };

    function splitArrayIntoGroups(array: number[], groupSize:number): number[][] {
    return array.reduce((result: number[][], value: number, index: number) => {
        if (index % groupSize === 0) {
        result.push([]);
        }
        result[result.length - 1].push(value);
        return result;
    }, []);
    }
</script>
<div class="sidebar">
    {#each Object.entries(uniforms) as [key, value]}
    <div>
    <strong>{key} ({getType(value)}):</strong>
    <!-- Render inputs based on type -->
        {#if (getType(value).startsWith("vec") || getType(value).startsWith("ivec")) && value instanceof Array}
            <table class="center-align">
                <thead>
                    <tr>
                        <th>x</th>
                        <th>y</th>
                        {#if value.length >= 3}
                            <th>z</th>
                        {/if}
                        {#if value.length >= 4}
                            <th>a</th>
                        {/if}
                    </tr>
                </thead>
                <tbody>
                    <tr>
                    {#each value as v, i}
                        <td class="s2 field small border">
                        <input
                            type="number"
                            step="0.01"
                            value={v}
                            on:input={(e) =>
                            updateUniform(key, i, parseFloat(e.currentTarget.value))}
                        />
                        </td>
                    {/each}
                    </tr>
                </tbody>
            </table>
        {:else if getType(value).startsWith("mat") && value instanceof Array}
            {#if value.length === 9}
                {#each splitArrayIntoGroups(value,3) as r, ri }
                    <!-- <table class="center-align">
                    <thead>
                        <tr>
                        {#if ri === 0}
                            <th>x0</th>
                            <th>x1</th>
                            <th>x2</th>
                        {/if}
                        {#if ri === 1}
                            <th>y0</th>
                            <th>y1</th>
                            <th>y2</th>
                        {/if}
                        {#if ri ===2}
                            <th>z0</th>
                            <th>z1</th>
                            <th>z2</th>
                        {/if}
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                        {#each r as c, ci }
                            <td class="s2 field small border">
                            <input
                                type="number"
                                step="0.01"
                                value={c}
                                on:input={(e) =>
                                updateUniform(key, ri * 3 + ci, parseFloat(e.currentTarget.value))}
                            />
                            </td>
                        {/each}
                        </tr>
                    </tbody>
                    </table> -->
                {/each}
            {/if}
        {:else if getType(value) === "bool" && typeof value === "boolean"}
            <!-- <label class="checkbox icon">
            <input
                type="checkbox"
                checked={value}
                on:change={(e) => updateUniform(key, null, e.currentTarget.checked)}
            />
            <span>
                <i>close</i>
                <i>done</i>
            </span>
            </label> -->
        {:else if getType(value) === "float" || getType(value) === "int"}
            <!-- <div class="grid">
                <div class="s2 field small border">
                    <input
                    type="number"
                    step="1"
                    {value}
                    on:input={(e) =>
                        updateUniform(
                        key,
                        null,
                        getType(value) === "int"
                            ? parseInt(e.currentTarget.value)
                            : parseFloat(e.currentTarget.value),
                        )}
                    />
                </div>
            </div> -->
        {:else if getType(value) === "sampler2D" && typeof value === "string"}
            <!-- <span>sampler2D (not editable)</span>
            <img class="small-width small-height" src={value} alt=""/> -->
        {:else}
            <span>Unsupported type</span>
        {/if}
    </div>
    {/each}
</div>
<style>
    .sidebar {
        width: 100%;
        height: 100%;
        padding: 10px;
        border: solid 1px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 10px 0;
        font-size: 14px;
        text-align: left;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 8px;
        overflow: hidden;
    }
    thead {
        background-color: #007BFF; /* Màu xanh header */
        color: #fff;
        text-transform: uppercase;
        font-weight: bold;
    }

    /* th, td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: center;
    } */

    /* th {
        font-size: 12px;
        letter-spacing: 0.5px;
    } */

    /* tbody tr {
        transition: background-color 0.2s ease-in-out;
    } */

    /* tbody tr:nth-child(even) {
        background-color: #f2f2f2; 
    } */

    /* tbody tr:hover {
        background-color: #e0f7fa;
    } */

    /* input[type="number"] {
        width: 80%;
        padding: 5px;
        font-size: 14px;
        border: 1px solid #ddd;
        border-radius: 4px;
        text-align: center;
    } */

    /* input[type="number"]:focus {
        outline: none;
        border-color: #007BFF;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    } */

</style>