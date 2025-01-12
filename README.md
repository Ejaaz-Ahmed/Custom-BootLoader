# Mentazzy Project: A Bootloader for 16-bit and Higher Architectures

**Authors**: Abdullah and Ejaz  
**Note**: This document is not an attempt to replace the documentation already written by Abdullah and Ejaz. It is written to show the steps to build an `.asm` (Assembly Language) file into an `.iso` (Disk Image) file on Windows.

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
