Uuid
====================

## install

```shell
ohpm install ohuuid
```

## usage

#### v4

```typescript
import { Uuid } from 'ohuuid'

console.log(`UuidV4 : ${Uuid.v4()}`)
```

#### v3

```typescript
import { Uuid, NameSpaces } from 'ohuuid'

let buffer = new ArrayBuffer(3);
let view = new DataView(buffer);
view.setUint8(0, 49);
view.setUint8(1, 50);
view.setUint8(2, 51);
let v3 = Uuid.v3(NameSpaces.DNS, view.buffer)
hilog.info(0x0000, 'testTag', '%{public}s', `v3 ${v3}`);
```



