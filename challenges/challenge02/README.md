## Challenge 02: IAM Privilege Escalation

### Scenario

You’ve been granted access to a GCP project `Challenge 02 - Project` with a minimal custom IAM role. Your current permissions appear limited and carefully scoped.

Within the project lies a Cloud Storage bucket, containing a sensitive file that you're not currently authorized to view.

### Mission

Your objective is to:

- Escalate your privileges using only the permissions assigned to you.
- Access the sensitive Cloud Storage bucket, read and enumerate the contents of the confidential file stored there.
