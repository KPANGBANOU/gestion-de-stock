 /*Container(
        child: StreamBuilder(
          stream: _userReference.doc(utilisateur!.uid).snapshots(),
          builder: (ctx, StreamSnapshot) {
            if (StreamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (StreamSnapshot.hasError) {
              return Center(
                child: Text("Une erreur s'est produite"),
              );
            } else if (!StreamSnapshot.hasData) {
              return Center(
                child: Text("Aucune donnée"),
              );
            }

            return Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text((StreamSnapshot.data as DocumentSnapshot)['nom'] ),
                Text((StreamSnapshot.data as DocumentSnapshot)['prenom']),
                Text((StreamSnapshot.data as DocumentSnapshot)['telephone']),
                Text((StreamSnapshot.data as DocumentSnapshot)['email']),
                Text((StreamSnapshot.data as DocumentSnapshot)['timestamp'].toString())
              ],
            );
          },
        ),
      ),*/