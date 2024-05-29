from PIL import Image

file_name = "avatar3"
file_type = "PNG"

# Load the image
image_path = f"{file_name}.{file_type}"
img = Image.open(image_path)

# Convert to RGBA (if not already in that mode)
img = img.convert("RGBA")

# Change resolution
img = img.resize((56, 64))

# Save as .ico
ico_path = f"{file_name}.ico"
img.save(ico_path, format="ICO")

ico_path
