data "null_data_source" "salt-master" {
  inputs = {
    fqdn = "salt.fritz.box"
  }
}

resource "proxmox_vm_qemu" "test-deployment" {
  count = 1
  name = "cloud.fritz.box"
  desc = "Cloud-init test machine"
  target_node = "pve"

  clone = "ubuntu1804-tmpl"
  cores = 1
  sockets = 1
  memory = 2048

  disk {
    id = 0
    type = "scsi"
    size = "10G"
    storage = "local-lvm"
    storage_type = "lvm"
  }
  network {
    id = 0
    bridge = "vmbr0"
    model = "virtio"
  }
  ssh_user = "root"
  ssh_private_key = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAobcX8cnqSkhX6LVkMbRLcUJyCYgLoBgwBLBrsuKXzV1E1cmN
JwCEUr+5s+lR7xkV695gErhLpPdqewMAhdOTln2K+HKab+je9vYEiTR6SBgqKy3+
F/26Pj/aXYDN9O1FkTfuXpFcjGoSlPLPH9vuwZ44QSnVXarcC427ZnYa/KhXHCBx
/TSxmpHpkEi1POLKuA8ijAiWDw/T8leHaz3NKQb1qnE8Ta94ZscmeSNGCxgGlQZI
txPWt/YQFkXOc8jwZsU33h0a5uXKxLTQjYOGCMDaW0Hw60PqicMESF+nH3bck4fo
SBWtnWMRqUR5IjZww4MkVP+9ZK7pffEY9F0x2wIDAQABAoIBAGHGGawOsKEI7F2+
jj2fDJ4F1nz8zEqXVTEAmZ0mczGvWpcHrVgPb/G4CcdFIky1lhNt+BhZZSLwlGib
gA1pxqoObZ+ZataOrYATbtql5+j+8z/4JtDKj3hjkttFrUCQ1KbgcjarHJGo8GMu
CxzwFILr7oc3i9F+JFy37L4eWmK3TvMfiP1AdSFIeecg88JYGV89EcJ4uGWIeIT/
3VYG+Qf1CScuH0p32NuAHstk7aOJzm/LV9JuUlKw0kwswzQi3vqksDgbG40selzF
jBGiPx4cF3r4ztJDPWwocht68mRwjG/EV55+YGpxPB5ZhYHR2nQfZl7efuvsrfx2
PBUXwQECgYEA1B3L4KBvYyBiPKiSi0ESL8ZIW8DuA5LOLgzVtgIePNcnI+9XM0Xr
Udo/IybZ04QWaxc1n8UwhtXv6JgAUnc3MPFFgcgGdMC9v14cO405RVNO9ubFr5jl
pAHcdqAnyFaBdCpCUZi0jBvK5/pQ3tqvJp2d6ItZAvkJ+hUvAfOh8lECgYEAwyvt
UxoI8qwG3+vubmT4e5NOCC3OyD/8MeDNG/SLO0B3+agjPsehMICwXWMcyLyBNPzz
ZTL48A0BoBiCEGwr6BmhIi6eJUteuy0fN95X5JovihijRDJCDpxUjVJV3J4/QuKg
CvW8nzNvSeLpPZXI9GoOnig0dw7lh7hTvK+pymsCgYA949vC1MzrTV2ceUsY2oml
6uLd8rL/0+vYv+HzUzbjZZuD/qegzDvXDCjz5rgT4SxxXrpEvdJk5TM02HTvmt09
qIgxT92iX0J9/cWbEp+tPJuDqt3vWFtYuTpMWnqBF8x5yoLDMB0t7EYN3ZmPDJui
VsbmPRJhraxdjaTDmwSboQKBgQCFX9V0/suymqCwEVkFE/dC661dpYA0FJXRuCAy
xHEJcssKTz6WvnGG5cqgZwTaoQdjIKFsPOMlmJ3NvDHV6zYuDKWy6Eymi9UW8ITu
9wD1dfCa3K9mATpnJaoaUXPfqjztBlX8Z2YZHVsmEOz3aw7DCF8o8ay41/M/RlXj
EeBkNQKBgE14c28F4zNuMbdh641PweJden/Jufcpb9TodxjNtR6Zg1gVXlm1yL0P
Z57ObzCczNx5MUjczYcXzCgSoX/4LdCbBOkvyt5VPF6ZWmGBNqds03aiEHp3f8uL
Tzy0OAmJvZK04eHJ4S3tFItxXiL5d4F/kjZNQvXDZo8VocRxdgI5
-----END RSA PRIVATE KEY-----
EOF

  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp,ip6=dhcp"
  ciuser = "ubuntu"
  cipassword = "ubuntu"
  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQChtxfxyepKSFfotWQxtEtxQnIJiAugGDAEsGuy4pfNXUTVyY0nAIRSv7mz6VHvGRXr3mASuEuk92p7AwCF05OWfYr4cppv6N729gSJNHpIGCorLf4X/bo+P9pdgM307UWRN+5ekVyMahKU8s8f2+7BnjhBKdVdqtwLjbtmdhr8qFccIHH9NLGakemQSLU84sq4DyKMCJYPD9PyV4drPc0pBvWqcTxNr3hmxyZ5I0YLGAaVBki3E9a39hAWRc5zyPBmxTfeHRrm5crEtNCNg4YIwNpbQfDrQ+qJwwRIX6cfdtyTh+hIFa2dYxGpRHkiNnDDgyRU/71krul98Rj0XTHb root@salt-master
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDg+TE+/eIHl1hJ3ACBmMVJHwl5p51TRuUDGYc3oAPmMGweA/YmH/w1Pn5lM+vW8wKsrbufVnX7YIaFLTzCc+P1a8co8sB2+YSeSrpLnYnOwivyKSUKi58HZAminpZCMkBoZOhJ8yUgweQVh80dxmcWrJPY33hVcgIGjWEGb5WBi27E6ntR7bh1xAl493Si5Z1bQ7Tacj3kZUTMO6n+D0dET/apZV3ig6aBBTpXp678xZmC5Kx29/CnjMPcUN69QU24fLxcI5lMDPlcmOCmkYPpA4f+Mvj74htu0Pxy/fw5YrAwAbWTzmMv8kSW83FzZsCavkuQ/GWR5KTH12Odtsk9 root@salt
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDc9bNq/M8IAj71LaGsI2vv9fi3nfUGwI1nr/jbUCQdgQv2EQvL07yhMkogqeaMwnf21O6I96NIU0ZiPVjSIRsEg1wxELoPbUGvIC5VPEwq39tKrh2OQMlT2spMxjvrvw9p8EM63Pv2PuobTmWeY5v5TGKh7X7v8wUmMoyJZynpqSqrCHs3oFb1xJaAlelYp4OpcvT411qHZPhGHARgceMCEG1Za8nTX2bV+KS3AjXEmgNjX7EKZCpSKZ4xwX9UzolAA+nlfHwBm6zwlqiK9LWf3P31jTnAMcgBEN+bgnbi/xUtW4sRnzIaipYpkFCpuYrcL8KSqyEGUWg0NvUM3abR7VmObQ3yfOMKKYswfamDMgPmO2E5rU5LO0Zb3ZjrZ0cS2rMSMkpMLW5OYoANRUNbcKoEyC5vfPYp8ci4xMtm1GiQ2Pku6kuxRy4MWhhF7hOVepA2HAs3cOGLnbCylRNLncaFY7AlRGoBrgs4IMdch+AleeIQiIi0LoQfYRePTbgYTJYT7FUWpKVGgQ3vlytc5oBpzjM9chog8XH9UxwDPoLTb43AkWGxVh9GTesRZk968Fg3SYd4wkhKraEJbdmo4ESAIwWDGdsrDYlJGuzUENdKRjzIh0tV3yyq28dDc4ZI4KvIthE7j7bN58PTTwd49sHMoilD1c7HZVsR/2g9Rw== m.mintert@billiger-mietwagen.de
EOF

}

