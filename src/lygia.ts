    function getFile(url: string): string {
//  function getFile(url: string): string {
        let httpRequest: XMLHttpRequest = new XMLHttpRequest();
//      let httpRequest: XMLHttpRequest = new XMLHttpRequest();
        httpRequest.open("GET", url, false);
//      httpRequest.open("GET", url, false);
        httpRequest.send();
//      httpRequest.send();
        if (httpRequest.status === 200) { return httpRequest.responseText; }
//      if (httpRequest.status === 200) { return httpRequest.responseText; }
        else { return ""; }
//      else { return ""; }
    }
//  }

    function resolveLygia(lines: string | string[]): string {
//  function resolveLygia(lines: string | string[]): string {
        if (!Array.isArray(lines)) {
//      if (!Array.isArray(lines)) {
            lines = lines.split(/\r?\n/);
//          lines = lines.split(/\r?\n/);
        }
//      }
        let src: string = "";
//      let src: string = "";
        lines.forEach((line: string, i: number): void => {
//      lines.forEach((line: string, i: number): void => {
            const line_trim: string = line.trim();
//          const line_trim: string = line.trim();
            if (line_trim.startsWith(`#include "lygia`)) {
//          if (line_trim.startsWith(`#include "lygia`)) {
                let include_url: string = line_trim.substring(15);
//              let include_url: string = line_trim.substring(15);
                include_url = "https://lygia.xyz" + include_url.replace(/\"|\;|\s/g, "");
//              include_url = "https://lygia.xyz" + include_url.replace(/\"|\;|\s/g, "");
                src += getFile(include_url) + "\n";
//              src += getFile(include_url) + "\n";
            } else {
//          } else {
                src += line + "\n";
//              src += line + "\n";
            }
//          }
        });
//      });
        return src;
//      return src;
    }
//  }

    async function resolveLygiaAsync(lines: string | string[]): Promise<string> {
//  async function resolveLygiaAsync(lines: string | string[]): Promise<string> {
        if (!Array.isArray(lines)) {
//      if (!Array.isArray(lines)) {
            lines = lines.split(/\r?\n/);
//          lines = lines.split(/\r?\n/);
        }
//      }
        let src: string = "";
//      let src: string = "";
        const response: string[] = await Promise.all(
//      const response: string[] = await Promise.all(
            lines.map(async (line: string, i: number): Promise<string> => {
//          lines.map(async (line: string, i: number): Promise<string> => {
                const line_trim: string = line.trim();
//              const line_trim: string = line.trim();
                if (line_trim.startsWith(`#include "lygia`)) {
//              if (line_trim.startsWith(`#include "lygia`)) {
                    let include_url: string = line_trim.substring(15);
//                  let include_url: string = line_trim.substring(15);
                    include_url = "https://lygia.xyz" + include_url.replace(/\"|\;|\s/g, "");
//                  include_url = "https://lygia.xyz" + include_url.replace(/\"|\;|\s/g, "");
                    return fetch(include_url).then((res: Response): Promise<string> => res.text());
//                  return fetch(include_url).then((res: Response): Promise<string> => res.text());
                } else { return line; }
//              } else { return line; }
            }),
//          }),
        );
//      );
        return response.join("\n");
//      return response.join("\n");
    }
//  }

    export {
//  export {
        getFile,
//      getFile,
        resolveLygia,
//      resolveLygia,
        resolveLygiaAsync,
//      resolveLygiaAsync,
    }
//  }
