import json

# Read completion data from file
with open('completion_data.json', 'r') as file:
    completion_data = json.load(file)

# Calculate completed module count
completed_modules = sum(module["Completed"] for module in completion_data["Modules"])
total_modules = completion_data["TotalModules"]
completion_percentage = (completed_modules / total_modules) * 100

# Read existing content from README.md
with open('README.md', 'r') as file:
    existing_content = file.read()

# Update README content
readme_content = existing_content.split("Currently, I completed ")[0]  # Get content before the completion status
readme_content += f"Currently, I completed {completed_modules} out of {total_modules} modules ({completion_percentage:.2f}%).\n\n"  # Add completion status with percentage
readme_content += "# Study Modules\n\n"
for module in completion_data["Modules"]:
    status = "Completed" if module["Completed"] else "Not Completed"
    readme_content += f"- Module {module['ModuleNumber']}: {module['Title']} - {status}\n"

readme_content += f"\nTotal Modules: {total_modules}\n"

# Write updated content to README.md
with open('README.md', 'w') as file:
    file.write(readme_content)
