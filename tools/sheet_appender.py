import os
import sys
import argparse
from PIL import Image

def append_sprites(foldername=".", output_filename="output.png"):
    # Get all PNG files in the folder
    files = [os.path.join(foldername, f) for f in os.listdir(foldername) if f.endswith(".png")]
    if not files:
        print("No PNG files found in the specified folder.")
        return

    # Sort files alphabetically for consistent ordering
    files.sort()

    # Open all images and find the total height and maximum width
    images = [Image.open(file) for file in files]
    max_width = max(img.width for img in images)
    total_height = sum(img.height for img in images)

    # Create a new blank image with a transparent background
    combined_image = Image.new("RGBA", (max_width, total_height), (0, 0, 0, 0))

    # Paste each image into the combined image
    y_offset = 0
    for img in images:
        combined_image.paste(img, (0, y_offset))  # Align to the left
        y_offset += img.height

    # Save the final combined image
    combined_image.save(output_filename)
    print(f"Sprite sheet saved as '{output_filename}'.")

def main():
    parser = argparse.ArgumentParser(description="Combine sprites into a single vertical sprite sheet.")
    parser.add_argument("-i", "--input", type=str, default=".", help="Input folder containing PNG files.")
    parser.add_argument("-o", "--output", type=str, default="output.png", help="Output filename for the combined sprite sheet.")
    args = parser.parse_args()

    append_sprites(foldername=args.input, output_filename=args.output)

if __name__ == "__main__":
    main()
