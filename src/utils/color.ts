    export async function doHexToRgbNormalized(hex: string): Promise<{ r: number, g: number, b: number, }> {
//  export async function doHexToRgbNormalized(hex: string): Promise<{ r: number, g: number, b: number, }> {
        hex = hex.replace(/^#/, "");
//      hex = hex.replace(/^#/, "");
        const r: number = parseInt(hex.substring(0, 2), 16) / 255;
//      const r: number = parseInt(hex.substring(0, 2), 16) / 255;
        const g: number = parseInt(hex.substring(2, 4), 16) / 255;
//      const g: number = parseInt(hex.substring(2, 4), 16) / 255;
        const b: number = parseInt(hex.substring(4, 6), 16) / 255;
//      const b: number = parseInt(hex.substring(4, 6), 16) / 255;
        return { r: r, g: g, b: b, };
//      return { r: r, g: g, b: b, };
    }
//  }

    export async function noHexToRgbNormalized(hex: string): Promise<{ r: number, g: number, b: number, }> {
//  export async function noHexToRgbNormalized(hex: string): Promise<{ r: number, g: number, b: number, }> {
        hex = hex.replace(/^#/, "");
//      hex = hex.replace(/^#/, "");
        const r: number = parseInt(hex.substring(0, 2), 16);
//      const r: number = parseInt(hex.substring(0, 2), 16);
        const g: number = parseInt(hex.substring(2, 4), 16);
//      const g: number = parseInt(hex.substring(2, 4), 16);
        const b: number = parseInt(hex.substring(4, 6), 16);
//      const b: number = parseInt(hex.substring(4, 6), 16);
        return { r: r, g: g, b: b, };
//      return { r: r, g: g, b: b, };
    }
//  }

    export async function rgba_ToHexNormalized(r: number, g: number, b: number, a: number): Promise<string> {
//  export async function rgba_ToHexNormalized(r: number, g: number, b: number, a: number): Promise<string> {
        r = Math.round(Math.max(0, Math.min(255, r)));
//      r = Math.round(Math.max(0, Math.min(255, r)));
        g = Math.round(Math.max(0, Math.min(255, g)));
//      g = Math.round(Math.max(0, Math.min(255, g)));
        b = Math.round(Math.max(0, Math.min(255, b)));
//      b = Math.round(Math.max(0, Math.min(255, b)));
        a = Math.round(Math.max(0, Math.min(255, a)));
//      a = Math.round(Math.max(0, Math.min(255, a)));
        const hex = `#${r.toString(16).padStart(2, "0")}${g.toString(16).padStart(2, "0")}${b.toString(16).padStart(2, "0")}${a.toString(16).padStart(2, "0")}`;
//      const hex = `#${r.toString(16).padStart(2, "0")}${g.toString(16).padStart(2, "0")}${b.toString(16).padStart(2, "0")}${a.toString(16).padStart(2, "0")}`;
        return hex;
//      return hex;
    }
//  }
