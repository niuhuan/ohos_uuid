Uuid 工具
=========

使用ArkTS实现的UUID工具

## 📦 安装

```shell
ohpm install ohuuid
```

## 📖 用例

#### 生成 UUIDv4 字符串

```typescript
import { Uuid } from 'ohuuid'

console.log(`UuidV4 : ${Uuid.v4()}`)
```

#### 生成 UUIDv3、UUIDv5 字符串

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

#### 将字节数组还原成UUID

```typescript
let src = "61122009-9aa1-1999-9ccf-fff7799ddff6";
let buffer = Uuid.parse(src);
console.log(`from ${src}`);
console.log(`  to ${buffer}`);
```

## 🔖 提示

#### 平台

单元测试或运行时时请注意以下内容

- v3、v5 用到了HashStream仅支持ArkTS平台
- v4 支持Ts全平台

#### 测试用例

[v4、parse](./src/test/UuidTest.test.ets)

[v3、v5](./src/ohosTest/ets/test/Ability.test.ets)



## 📕 协议

参考 [LICENSE](./LICENSE) 文件
