alias Circuits.I2C

{:ok, ref} = I2C.open("i2c-1")

# Select pin 24
I2C.write(ref, 0x49, <<0x0E, 1, 24>>)

# Select speed 1 (800khz)
I2C.write(ref, 0x49, <<0x0E, 2, 1>>)

# Address a n pixels (5 * n byte buffer)
I2C.write(ref, 0x49, <<0x0E, 3, 0, 2 + 3 * 4>>)

# Set the nth pixel a color
# Note this is in GRB for some odd reason

I2C.write(ref, 0x49, <<0x0E, 4, 0, 0,
  10, 105, 207,
  10, 105, 207,
  10, 105, 207,
  10, 105, 207,
>>)

# Display
I2C.write(ref, 0x49, <<0x0E, 5>>)

color = fn r, g, b ->
  I2C.write(ref, 0x49, <<0x0E, 4, 0, 0,
    g, r, b,
    g, r, b,
    g, r, b,
    g, r, b
  >>)
  I2C.write(ref, 0x49, <<0x0E, 5>>)
end
