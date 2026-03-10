import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //variables pour les widgets interactifs
  bool switchValue = false;
  bool checkboxValue = false;
  String dropdownValue = "Option 1";

  //controller pour recuperer le texte du  textfield
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final AuthService authService = AuthService();

    //fonction de déconnexion
    void logout() async {
      await authService.logout();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
      );
    }

    return Scaffold(
      //Barre en haut de l'application
      appBar: AppBar(
        title: const Text("Administration ipm"),
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      //Barre de menu
      drawer: Drawer(
        child: ListView(
          children: const [

            //entête du menu
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu Principal",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),

            //elément du menu
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Accueil"),
            ),

            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Paramètres"),
            ),
          ],
        ),
      ),

      //Body
      body: Padding(
        padding: const EdgeInsets.all(16),

        //ListView permet de scroller la page
        child: ListView(
          children: [

            // Text
            const Text(
              "Bienvenue a l'IPM",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Cette page montre plusieurs widgets importants de Flutter pour les étudiants de l'IPM.",
            ),

            const Divider(),

            //Textfield
            // champ pour saisir du texte
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Entrer votre nom",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            // Row
            // permet d'aligner les widgets horizontalement
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.home),
                Icon(Icons.favorite),
                Icon(Icons.settings),
              ],
            ),

            const Divider(),

            // BOUTON
            ElevatedButton(
              onPressed: () {

                // Snackbar = message temporaire
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Bonjour ${nameController.text}"),
                  ),
                );
              },
              child: const Text("Afficher Bonjour"),
            ),

            const SizedBox(height: 10),

            // autres types de boutons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // bouton simple
                TextButton(
                  onPressed: () {},
                  child: const Text("TextButton"),
                ),

                //bouton avec contour
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("OutlinedButton"),
                ),
              ],
            ),

            const Divider(),

            //SWITCH
            SwitchListTile(
              title: const Text("Activer les notifications"),
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
              },
            ),

            //CHECKBOX
            CheckboxListTile(
              title: const Text("Accepter les conditions"),
              value: checkboxValue,
              onChanged: (value) {
                setState(() {
                  checkboxValue = value!;
                });
              },
            ),

            const Divider(),

            //DROPDOWN
            DropdownButtonFormField(
              value: dropdownValue,
              items: const [
                DropdownMenuItem(
                  value: "Option 1",
                  child: Text("Opt 1"),
                ),
                DropdownMenuItem(
                  value: "Option 2",
                  child: Text("Opt 2"),
                ),
                DropdownMenuItem(
                  value: "Option 3",
                  child: Text("Opt 3"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Choisir une option",
                border: OutlineInputBorder(),
              ),
            ),

            const Divider(),

            // CARD
            Card(
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.school),
                title: const Text("Licence 3 Informatique"),
                subtitle: const Text("Cours dev mobile "),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {

                  //Dialog = popup
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Information"),
                        content: const Text("Vous avez cliqué sur la carte"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Fermer"),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            //LISTVIEW
            const Text(
              "Liste des étudiants",
              style: TextStyle(fontSize: 18),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text("Etudiant ${index + 1}"),
                );
              },
            ),
          ],
        ),
      ),

      // FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Floating Button cliqué")),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}