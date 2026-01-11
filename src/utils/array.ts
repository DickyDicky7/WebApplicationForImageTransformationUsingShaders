    export function splitArrayIntoGroups<T>(array: T[], groupSize: number): T[][] {
//  export function splitArrayIntoGroups<T>(array: T[], groupSize: number): T[][] {
        return array.reduce((result: T[][], value: T, index: number): T[][] => {
//      return array.reduce((result: T[][], value: T, index: number): T[][] => {
            if (index % groupSize === 0) {
//          if (index % groupSize === 0) {
                result.push([]);
//              result.push([]);
            }
//          }
            result[result.length - 1].push(value);
//          result[result.length - 1].push(value);
            return result;
//          return result;
        }, []);
//      }, []);
    }
//  }
