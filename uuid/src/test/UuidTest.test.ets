import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { Uuid } from '../../Index';

export default function uuidTest() {
  describe('UuidTest', () => {
    it("v4", 0, () => {
      let v4 = Uuid.v4()
      console.log(`v4 ${v4}`)
    })
  })
}
