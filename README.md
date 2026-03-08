# System Health Report Tool

A PowerShell-based diagnostic tool that collects key system information and generates a structured report.
The tool helps users quickly analyze the health and performance of a Windows system.

This project also provides a compiled **EXE version** for users who prefer running the tool without PowerShell configuration.

---

# Features

* Disk usage analysis
* CPU load monitoring
* RAM usage statistics
* Top 5 memory-consuming processes
* Running Windows services list
* Automated system report generation
* Portable executable version (.exe)

---

# Project Structure

```
system-health-report/
│
├── src/
│   └── system-report.ps1
│
├── dist/
│   └── SystemInsight.exe
│
├── tool/
│   ├── ps2exe.ps1
│   └── Win-PS2EXE-GUI.exe
│
├── sample-report.txt
└── README.md
```

### Folder Description

| Folder              | Purpose                     |
| ------------------- | --------------------------- |
| `src`               | PowerShell source script    |
| `dist`              | Compiled executable version |
| `tools`             | PS2EXE conversion tools     |
| `sample-report.txt` | Example generated report    |

---

# How to Run the Tool

You can run the project in two ways:

1. Run the **PowerShell script (.ps1)**
2. Run the **compiled executable (.exe)**

---

# Method 1 — Run the PowerShell Script (.ps1)

### Step 1: Download the Project

Clone the repository:

```
git clone https://github.com/your-username/system-health-report.git
```

Or download the ZIP from GitHub and extract it.

---

### Step 2: Navigate to the Script Folder

Open PowerShell and run:

```
cd system-health-report/src
```

---

### Step 3: Allow Script Execution (If Required)

If PowerShell blocks the script:

```
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

### Step 4: Run the Script

```
.\system-report.ps1
```

---

### Output

A system report will be generated in the **Downloads folder** of the current user.

Example path:

```
C:\Users\<username>\Downloads\report.txt
```

---

# Method 2 — Run the Executable (.exe)

The repository also provides a compiled executable version.

### Step 1: Download the EXE

Download from:

```
dist/SystemInsight.exe
```

Or download it from the **GitHub Releases section**.

---

### Step 2: Run the Application

Simply double-click:

```
SystemInsight.exe
```

No PowerShell configuration is required.

The tool will automatically generate the system report.

---

# Converting PowerShell Script to EXE

This project uses the **PS2EXE** tool to convert PowerShell scripts into standalone executables.

Official project:
https://github.com/MScholtes/PS2EXE

Two methods are provided:

* Command Line
* Graphical Interface

---

# Method 1 — Using Command Line

Navigate to the tools directory:

```
cd tools
```

Run:

```
powershell -ExecutionPolicy Bypass -File ps2exe.ps1 `
-inputFile ..\src\system-report.ps1 `
-outputFile ..\dist\SystemInsight.exe
```
---

# Method 2 — Using the GUI Tool

The project includes a graphical converter:

```
tools/Win-PS2EXE.exe
```

### Steps

1. Open **Win-PS2EXE-GUI.exe**
2. In **Source File**, select:

```
src/system-report.ps1
```

3. In **Target File**, choose:

```
dist/SystemInsight.exe
```

4. Click **Compile**

The EXE file will be generated automatically.

---

# Example Output

The tool generates a report similar to:

```
=== System Status Report ===

---- Disk Usage ----
Drive   Used(GB)   Free(GB)

---- CPU Usage ----
Processor Load Percentage

---- Memory Usage ----
Total RAM
Used RAM
Free RAM

---- Top Processes ----
Top 5 processes by memory consumption

---- Running Services ----
List of currently running Windows services
```

---

# Use Cases

This tool can be useful for:

* IT support diagnostics
* System health checks
* Troubleshooting slow systems
* Performance monitoring
* Automated system auditing

---

# ⚠️Security Note
The source code is provided so users can review the script before running the executable.
You may also compile the executable yourself using the included PS2EXE tool.


---

# Author

Sutharsan Senthil
