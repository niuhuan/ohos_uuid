import { hash } from '@kit.CoreFileKit';

const hexChars = "0123456789abcdef"

export interface UuidInterface {
  data: Uint8Array

  toString(): string
}

export class Uuid implements UuidInterface {
  protected _data: Uint8Array;

  public get data(): Uint8Array {
    return this._data;
  }

  constructor(data: Uint8Array) {
    this._data = data;
  }

  public static parse(str: string): Uuid {
    let uuidStr = str.replaceAll('-', '');
    if (uuidStr.length != 32) {
      throw new SyntaxError("uuid string length error");
    }
    if (!uuidStr.match(/^[0-9A-Fa-f]{32}$/)) {
      throw new SyntaxError("uuid string format error, A UUID is a 128-bit number displayed in five groups separated by hyphens, in the form 8-4-4-4-12 for a total of 36 characters (32 alphanumeric characters and 4 hyphens). For example: 123e4567-e89b-12d3-a456-426614174000 ");
    }
    uuidStr = uuidStr.toLowerCase();
    let buffer = new ArrayBuffer(16);
    const view = new DataView(buffer);
    for (let i = 0; i < uuidStr.length; i += 2) {
      let high = uuidStr.charAt(i);
      let low = uuidStr.charAt(i + 1);
      let highValue = hexChars.indexOf(high);
      let lowValue = hexChars.indexOf(low);
      let idxValue = (highValue << 4) | lowValue;
      view.setUint8(i / 2, idxValue & 0xFF);
    }
    let dataArray = new Uint8Array(buffer);
    return new Uuid(dataArray);
  }

  public static v4(): string {
    return Uuid.v4Instance().toString();
  }

  public static v4Instance(): UuidV4 {
    return new UuidV4();
  }

  public static v3(namespace: UuidInterface, name: ArrayBuffer): string {
    return Uuid.v3Instance(namespace, name).toString();
  }

  public static v3Instance(namespace: UuidInterface, name: ArrayBuffer): Uuid {
    return new UuidV3(namespace, name);
  }

  toString(): string {
    let hex = "";
    for (let i = 0; i < this._data.length; i++) {
      if (i == 4 || i == 6 || i == 8 || i == 10) {
        hex += '-';
      }
      const byte = this._data[i];
      hex += hexChars.charAt((byte >> 4) & 0x0f) + hexChars.charAt(byte & 0x0f);
    }
    return hex;
  }
}

export interface NameSpacesInterface {
  DNS: UuidInterface,
  URL: UuidInterface,
  OID: UuidInterface,
  X500: UuidInterface,
}

export const NameSpaces: NameSpacesInterface = {
  DNS: Uuid.parse("6ba7b810-9dad-11d1-80b4-00c04fd430c8"),
  URL: Uuid.parse("6ba7b811-9dad-11d1-80b4-00c04fd430c8"),
  OID: Uuid.parse("6ba7b812-9dad-11d1-80b4-00c04fd430c8"),
  X500: Uuid.parse("6ba7b814-9dad-11d1-80b4-00c04fd430c8"),
}

// DATA:
// RANDOM 128 bytes
// AND calculate
// POSITION & 0x 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 | 0x 06 07 08 09 10 11 12 13 14 15
//     DATA & 0x FF FF FF FF FF FF 4F FF BF FF FF FF FF FF FF FF | 0x 40 00 80 00 00 00 00 00 00 00
// STR-FORMAT: 8-4-4-4-12
export class UuidV4 extends Uuid {
  constructor() {
    super(UuidV4.generate());
  }

  static generate(): Uint8Array {
    let buffer = new ArrayBuffer(16);
    const view = new DataView(buffer);
    for (let i = 0; i < 4; i++) {
      view.setUint32(4 * i, (Math.random() * 0xFFFFFFFFFF) ^ 0xFFFFFFFF);
    }
    view.setUint8(6, view.getUint8(6) & 0x4F | 0x40);
    view.setUint8(8, view.getUint8(8) & 0xBF | 0x80);
    return new Uint8Array(buffer);
  }
}

export class UuidV3 extends Uuid {
  constructor(namespace: UuidInterface, name: ArrayBuffer) {
    super(UuidV3.generate(namespace, name))
  }

  static generate(namespace: UuidInterface, name: ArrayBuffer): Uint8Array {
    const hashStream = hash.createHash("md5");
    hashStream.update(namespace.data.buffer);
    hashStream.update(name);
    const digest = hashStream.digest();
    const data = Uuid.parse(digest).data;
    data[6] = (data[6] & 0x0f) | 0x30;
    data[8] = (data[8] & 0x3f) | 0x80;
    return data;
  }
}
