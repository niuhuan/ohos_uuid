import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { NameSpaces, Uuid } from '../../../../Index';

export default function abilityTest() {
  describe('ActsAbilityTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    it('v3', 0, () => {
      let buffer = new ArrayBuffer(3);
      let view = new DataView(buffer);
      view.setUint8(0, 49);
      view.setUint8(1, 50);
      view.setUint8(2, 51);
      let v3 = Uuid.v3(NameSpaces.DNS, view.buffer)
      hilog.info(0x0000, 'testTag', '%{public}s', `v3 ${v3}`);
    })
  })
}