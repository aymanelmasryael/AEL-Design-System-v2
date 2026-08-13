import Foundation

// MARK: - HSL / HSV / CMYK

extension AELColor {

    public static func rgbToHSL(red: Double, green: Double, blue: Double, alpha: Double = 1.0)
        -> (h: Double, s: Double, l: Double, a: Double) {
        let r = red, g = green, b = blue
        let max = Swift.max(r, g, b)
        let min = Swift.min(r, g, b)
        let delta = max - min

        var h = 0.0
        if delta != 0 {
            if max == r { h = 60.0 * ((g - b) / delta) }
            else if max == g { h = 60.0 * ((b - r) / delta + 2.0) }
            else { h = 60.0 * ((r - g) / delta + 4.0) }
        }
        if h < 0 { h += 360.0 }

        let l = (max + min) / 2.0
        let s = delta == 0 ? 0.0 : delta / (1.0 - abs(2.0 * l - 1.0))
        return (h, s, l, alpha)
    }

    public static func rgbToHSV(red: Double, green: Double, blue: Double, alpha: Double = 1.0)
        -> (h: Double, s: Double, v: Double, a: Double) {
        let r = red, g = green, b = blue
        let max = Swift.max(r, g, b)
        let min = Swift.min(r, g, b)
        let delta = max - min

        var h = 0.0
        if delta != 0 {
            if max == r { h = 60.0 * ((g - b) / delta) }
            else if max == g { h = 60.0 * ((b - r) / delta + 2.0) }
            else { h = 60.0 * ((r - g) / delta + 4.0) }
        }
        if h < 0 { h += 360.0 }

        let s = max == 0 ? 0.0 : delta / max
        return (h, s, max, alpha)
    }

    public static func rgbToCMYK(red: Double, green: Double, blue: Double, alpha: Double = 1.0)
        -> (c: Double, m: Double, y: Double, k: Double, a: Double) {
        let r = red, g = green, b = blue
        let k = 1.0 - Swift.max(r, g, b)
        if k >= 1.0 { return (0, 0, 0, 1, alpha) }
        let c = (1.0 - r - k) / (1.0 - k)
        let m = (1.0 - g - k) / (1.0 - k)
        let y = (1.0 - b - k) / (1.0 - k)
        return (c, m, y, k, alpha)
    }
}

// MARK: - OKLab (Björn Ottosson, 2020)

extension AELColor {

    /// sRGB -> OKLab. Matrix and cube-root per Ottosson's reference implementation.
    public static func srgbToOKLab(red: Double, green: Double, blue: Double) -> (L: Double, a: Double, b: Double) {
        let l = srgbToLinear(red)
        let m = srgbToLinear(green)
        let s = srgbToLinear(blue)

        let l_ = cbrt(0.4122214708 * l + 0.5363325363 * m + 0.0514459929 * s)
        let m_ = cbrt(0.2119034982 * l + 0.6806995451 * m + 0.1073969566 * s)
        let s_ = cbrt(0.0883024619 * l + 0.2817188376 * m + 0.6299787005 * s)

        return (
            L: 0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
            a: 1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
            b: 0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_
        )
    }
}

// MARK: - CIELAB (CIE 1931 XYZ D65)

extension AELColor {

    public static func xyzToCIELAB(_ xyz: (x: Double, y: Double, z: Double))
        -> (L: Double, a: Double, b: Double) {
        let xn = 0.95047, yn = 1.0, zn = 1.08883
        let fx = fT(xyz.x / xn)
        let fy = fT(xyz.y / yn)
        let fz = fT(xyz.z / zn)
        return (
            L: 116.0 * fy - 16.0,
            a: 500.0 * (fx - fy),
            b: 200.0 * (fy - fz)
        )
    }

    private static func fT(_ t: Double) -> Double {
        let delta = 6.0 / 29.0
        if t > delta * delta * delta {
            return cbrt(t)
        }
        return t / (3.0 * delta * delta) + 4.0 / 29.0
    }
}
