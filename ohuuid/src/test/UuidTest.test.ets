import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { Uuid } from '../../Index';

export default function uuidTest() {
  describe('UuidTest', () => {
    it("v4", 0, () => {
      let v4 = Uuid.v4()
      console.log(`v4 ${v4}`)
    })
    it("parse", 0, () => {
      let src = "61122009-9aa1-1999-9ccf-fff7799ddff6";
      let buffer = Uuid.parse(src);
      console.log(`from ${src}`);
      console.log(`  to ${buffer}`);
    })
  })
}
