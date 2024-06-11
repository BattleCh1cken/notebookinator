/// Returns the raw image data, not image content
/// You'll still need to run image.decode on the result
///
/// - raw-icon (string): The raw data for the image. Must be svg data.
/// - fill (color): The new icon color
/// -> string
#let change-icon-color(
  raw-icon: "",
  fill: red,
) = {
  return raw-icon.replace(
    "<path",
    "<path style=\"fill: " + fill.to-hex() + "\"",
  )
}

/// Takes the path to an icon as input, recolors that icon, and then returns the decoded image as output.
///
/// - path (string): The path to the icon. Must point to a svg.
/// - fill (color): The new icon color.
/// - width (ratio length): Width of the image
/// - height (ratio length): height of the image
/// - fit (string): How the image should adjust itself to a given area. Takes either "cover", "contain", or "stretch"
/// -> content
#let colored-icon(
  path,
  fill: red,
  width: 100%,
  height: 100%,
  fit: "contain",
) = {
  let raw-icon = read(path)
  let raw-colored-icon = raw-icon.replace(
    "<path",
    "<path style=\"fill: " + fill.to-hex() + "\"",
  )
  return image.decode(
    raw-colored-icon,
    width: width,
    height: height,
    fit: fit,
  )
}
