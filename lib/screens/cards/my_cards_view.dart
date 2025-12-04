import 'package:flutter/material.dart';
import 'package:metalixmovil/services/banista_card_service.dart';

class MyCardsView extends StatefulWidget {
  final int userId; // id_banista

  const MyCardsView({super.key, required this.userId});

  @override
  State<MyCardsView> createState() => _MyCardsViewState();
}

class _MyCardsViewState extends State<MyCardsView> {
  final Color mainColor = const Color(0xFF1FC7DB);

  List<Map<String, dynamic>> userCards = [];
  bool loading = true;

  final TextEditingController cardCodeController = TextEditingController();

  // ============================================================
  // 🔹 LOAD CARDS FROM BANISTA BACKEND
  // ============================================================
  Future<void> loadCards() async {
    setState(() => loading = true);

    try {
      userCards = await BanistaCardService.getCardsByBanista(widget.userId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading cards: $e")),
      );
    }

    setState(() => loading = false);
  }

  // ============================================================
  // 🔹 VINCULAR CARD
  // ============================================================
  Future<void> linkCard() async {
    final code = cardCodeController.text.trim();
    if (code.isEmpty) return;

    try {
      await BanistaCardService.linkCard(code, widget.userId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Card linked successfully!")),
      );

      Navigator.pop(context);
      cardCodeController.clear();
      await loadCards(); // reload list

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error linking card: $e")),
      );
    }
  }

  // ============================================================
  // 🔹 DESVINCULAR CARD
  // ============================================================
  Future<void> unlinkCard(String cardCode) async {
    try {
      await BanistaCardService.unlinkCard(cardCode);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Card unlinked.")),
      );

      await loadCards();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  // ============================================================
  // ADD CARD MODAL
  // ============================================================
  void _openAddCardModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Link Card"),
        content: TextField(
          controller: cardCodeController,
          decoration: InputDecoration(
            labelText: "Card Code",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: mainColor),
            onPressed: linkCard,
            child: const Text("Link", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  // ============================================================
  // UI
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "My Cards",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _openAddCardModal,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Link Card", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: mainColor),
              ),
            ],
          ),

          const SizedBox(height: 20),

          if (loading)
            const Center(child: CircularProgressIndicator()),

          if (!loading && userCards.isEmpty)
            const Center(child: Text("No cards linked.")),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: userCards.length,
            itemBuilder: (context, index) {
              final card = userCards[index];

              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: mainColor.withOpacity(0.15),
                    child: const Icon(Icons.credit_card, color: Colors.black87),
                  ),
                  title: Text(card["card_code"] ?? "Unknown"),
                  subtitle: Text("Card ID: ${card["id"]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => unlinkCard(card["card_code"]),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
