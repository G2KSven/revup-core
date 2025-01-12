import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../auth/auth.dart';
import '../stores/repair_records/repair_records.dart';
import '../stores/stores.u.dart';
import '../stores/users/users.dart';

MultiRepositoryProvider coreRepositoryProviders({required Widget providers}) =>
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuth>(create: (_) => FirebaseAuth.instance),
        RepositoryProvider<FirebaseFirestore>(
          create: (_) => FirebaseFirestore.instance,
        ),
        RepositoryProvider<GoogleSignIn>(create: (_) => GoogleSignIn()),
        RepositoryProvider<IStore<AppUser>>(
          create: (context) => UserRepository(context.read()),
        ),
        RepositoryProvider<IStore<RepairRecord>>(
          create: (context) => RepairRecordRepository(context.read()),
        ),
        RepositoryProvider<GoogleAuthenticator>(
          create: (context) => GoogleAuthenticator(
            context.read(),
            context.read(),
            context.read<IStore<AppUser>>() as UserRepository,
          ),
        ),
        RepositoryProvider<PhoneAuthenticator>(
          create: (context) => PhoneAuthenticator(
            context.read(),
            context.read<IStore<AppUser>>() as UserRepository,
          ),
        ),
        RepositoryProvider<AuthenticatorRepository>(
          create: (context) =>
              AuthenticatorRepository(context.read(), context.read()),
        ),
      ],
      child: providers,
    );
