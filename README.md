# Linux-Bash-Utilities

### Proje Hakkında
Bu proje, Linux ortamında sıkça ihtiyaç duyulan **sistem yönetimi, dosya manipülasyonu ve metin işleme** görevlerini otomatize etmek amacıyla geliştirilmiştir. İçerisinde yedekleme, toplu dosya isimlendirme, kelime frekans analizi ve dosya sınıflandırma gibi işlevleri yerine getiren modüler **Bash scriptleri** bulunur. `grep`, `sed`, `awk` ve `find` gibi güçlü Linux araçlarının efektif kullanımını ve Shell programlama mantığını örnekleyen pratik bir araç setidir.

### About the Project
This project is developed to automate common **system administration, file manipulation, and text processing** tasks in the Linux environment. It contains modular **Bash scripts** that perform functions such as backup, bulk file renaming, word frequency analysis, and file sorting. It serves as a practical toolkit demonstrating the effective use of powerful Linux tools like `grep`, `sed`, `awk`, and `find`, along with Shell programming logic.

---

###  Dosyalar / Files

* **`myprog1.sh`**: Metin dosyası içindeki kelime frekans analizi (Word Frequency Analysis).
* **`myprog2.sh`**: Belirli dosyaları tarihli bir klasöre yedekleme (Auto Backup).
* **`myprog3.sh`**: Metin değiştirme ve log tutma (Find & Replace with Logging).
* **`myprog4.sh`**: Dosyaları boyutuna göre (Büyük/Küçük) ayıklama (File Sorter by Size).
* **`myprog5.sh`**: Toplu dosya yeniden adlandırma (Bulk Renamer - Recursive).

---

###  Kurulum / Setup

Scriptleri çalıştırmak için dosyalara izin vermeniz yeterlidir.
To run the scripts, simply grant execution permissions:

```bash
git clone [https://github.com/DoguSahin11/Linux-Bash-Utilities.git](https://github.com/DoguSahin11/Linux-Bash-Utilities.git)
cd Linux-Bash-Utilities/src

chmod +x *.sh

# Örnek / Example:
./myprog1.sh sample.txt
