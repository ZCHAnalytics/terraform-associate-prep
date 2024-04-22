import json

# Read completion data from file
with open('completion_data.json', 'r') as file:
    completion_data = json.load(file)

# Read existing content from README.md
with open('README.md', 'r') as file:
    existing_content = file.read()

# Update README content
readme_content = existing_content.split("Currently, I completed ")[0]  # Get content before the completion status
readme_content += f"Currently, I completed {completion_data['CompletedModules']} out of {completion_data['TotalModules']} modules.\n\n"  # Add completion status
readme_content += "# Study Modules\n\n"
for module in completion_data["Modules"]:
    status = "Completed" if module["Completed"] else "Not Completed"
    readme_content += f"- Module {module['ModuleNumber']}: {module['Title']} - {status}\n"

readme_content += f"\nTotal Modules: {completion_data['TotalModules']}\n"

# Write updated content to README.md
with open('README.md', 'w') as file:
    file.write(readme_content)
