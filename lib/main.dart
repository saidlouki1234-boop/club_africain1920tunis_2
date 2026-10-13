
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const clubRed = Color(0xFFB5122B);
const tikTok = 'https://www.tiktok.com/@club_africain1920tunis';
const instagram =
    'https://instagram.com/club_africain1920tunis';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const url = String.fromEnvironment('SUPABASE_URL');
  const key = String.fromEnvironment('SUPABASE_ANON_KEY');

  if (url.isNotEmpty && key.isNotEmpty) {
    await Supabase.initialize(
      url: url,
      anonKey: key,
    );
  }

  runApp(const ClubApp());
}

class ClubApp extends StatelessWidget {
  const ClubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'النادي الإفريقي',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: clubRed),
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  final titles = [
    'الرئيسية',
    'الأخبار',
    'المباريات',
    'التوقعات',
    'حسابي',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clubRed,
        foregroundColor: Colors.white,
        title: Text('❤️🤍 النادي الإفريقي'),
      ),
      body: IndexedStack(
        index: page,
        children: [
          const Dashboard(),
          const NewsPage(),
          const MatchesPage(),
          const PredictionsPage(),
          const AccountPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: page,
        onDestinationSelected: (i) {
          setState(() => page = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: 'الأخبار',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'المباريات',
          ),
          NavigationDestination(
            icon: Icon(Icons.poll),
            label: 'التوقعات',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: clubRed,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            children: [
              Icon(
                Icons.shield,
                color: Colors.white,
                size: 65,
              ),
              SizedBox(height: 12),
              Text(
                'CLUB AFRICAIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'نادي الشعب ❤️🤍',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Text(
                'أخبار • مباريات • توقّعات',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'مرحبًا بجماهير الأحمر والأبيض!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'تابع أخبار النادي الإفريقي ومواعيد المباريات '
          'وشارك توقّعاتك مع الجماهير.',
        ),
        const SizedBox(height: 20),
        SocialButton(
          label: 'تابعنا على TikTok',
          url: tikTok,
          icon: Icons.play_arrow,
        ),
        SocialButton(
          label: 'تابعنا على Instagram',
          url: instagram,
          icon: Icons.camera_alt,
        ),
      ],
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text(
          '📰 أخبار النادي الإفريقي\n'
          'ستظهر الأخبار المنشورة من قاعدة البيانات هنا.',
          textAlign: TextAlign.center,
        ),
      );
}

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text(
          '⚽ مواعيد المباريات والنتائج\n'
          'ستظهر المباريات بعد ربط Supabase.',
          textAlign: TextAlign.center,
        ),
      );
}

class PredictionsPage extends StatelessWidget {
  const PredictionsPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text(
          '🗳️ توقّعات الجماهير\n'
          'شارك توقّعك لنتيجة المباراة.',
          textAlign: TextAlign.center,
        ),
      );
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text(
          '👤 حساب المشجع\n'
          'سيُضاف تسجيل الدخول عبر Supabase.',
          textAlign: TextAlign.center,
        ),
      );
}

class SocialButton extends StatelessWidget {
  final String label;
  final String url;
  final IconData icon;

  const SocialButton({
    super.key,
    required this.label,
    required this.url,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: clubRed,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () async {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          },
          icon: Icon(icon),
          label: Text(label),
        ),
      ),
    );
  }
}
