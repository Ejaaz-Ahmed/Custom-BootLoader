# Mentazzy Project: A Bootloader for 16-bit and Higher Architectures

**Authors**: <br>
- Ejaz Ahmed
- Abdullah  
**Note**: It is written to show the steps to build an `.asm` (Assembly Language) file into an `.iso` (Disk Image) file on Windows.

---

## Tools

- **NASM**
- **CDRTOOLS** (or equivalent tools)
- **VirtualBox**
- **Notepad** (should already be available on Windows)

---

## Steps to Build the Project

With all the tools installed and ready to work under the `asm` directory, we can begin building the project.

---

### Step One: Write the Assembly Code

1. Open **Notepad**.
2. Type or copy and paste the assembly example (`myfirst.asm`) code located on this page into Notepad.
3. Save the file as `myfirst.asm` in the `c:\asm\` directory.

**Note**: To navigate to the `asm` directory in the Command Console, type the following command and press Enter:

```bash
cd asm
```
## Step Two: Build the `.asm` File to a Binary File

Build the `myfirst.asm` file into the `firstOS.bin` file in the `c:\asm\` directory by typing the following command:

```bash
nasm -f bin -o firstOS.bin firstOS.asm
```
## Step Three: Create a Floppy Disk Image

Convert the `firstOS.bin` file into a floppy disk image (`firstOS.flp`) by typing the following command:

```bash
copy /b firstOS.bin firstOS.flp

```
## Step Four: Create a Directory for the ISO

Once the `firstOS.flp` file is created, make another directory named `cdiso` inside the `asm` directory. Use the following command:

```bash
md cdiso
```
## Step Five: Copy the Floppy Image to the New Directory

Copy the `firstOS.flp` file from the asm directory to the cdiso directory. Use the following command:

```bash
firstOS.flp c:\asm\cdiso
```
## Step Six: Build the ISO File

The final step is to build the `firstOS.iso` file. The CDRTOOLS package includes the `mkisofs.exe` file, which is similar to the Linux command used to create `.iso` files. For the Windows version of mkisofs, type the following command in the Console Window:

```bash
mkisofs -no-emul-boot -boot-load-size 4 -o firstOS.iso -b firstOS.flp cdiso/
```
## Expected Output

When the command is executed, you should see output similar to the following:

```bash
Size of boot image is 4 sectors -> No emulation
Total translation table size: 2048
Total rockridge attributes bytes: 0
Total directory bytes: 158s
Path table size(bytes): 10
Max brk space used 3000
56 extents written (0 Mb)
```
The firstOS.iso file will now be located in the c:\asm\ directory.
## Interface:
![The Interface](https://github.com/Ejaaz-Ahmed/Custom-BootLoader/blob/main/images/image_2025-01-12_164654001.png)
