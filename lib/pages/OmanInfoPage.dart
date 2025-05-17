import 'package:flutter/material.dart';
import 'package:course_project/models/omanInfoModel.dart';
import 'package:course_project/services/oman_info_service.dart';

class OmanInfoPage extends StatefulWidget {
  @override
  State<OmanInfoPage> createState() => _OmanInfoPageState();
}

class _OmanInfoPageState extends State<OmanInfoPage> {
  final TextEditingController _searchController = TextEditingController();
  final OmanInfoService _omanInfoService = OmanInfoService();

  @override
  void initState() {
    super.initState();
    _omanInfoService.addInitialData();
  }

  List<OmanInfoModel> _filterData(String query, List<OmanInfoModel> allData) {
    if (query.isEmpty) {
      return allData;
    }
    return allData.where((info) {
      return info.title.toLowerCase().contains(query.toLowerCase()) ||
             info.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover Oman'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search places...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (query) {
                setState(() {}); // Trigger rebuild to update filtered results
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<OmanInfoModel>>(
              stream: _omanInfoService.getOmanInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final allData = snapshot.data!;
                final filteredData = _filterData(_searchController.text, allData);

                return GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final info = filteredData[index];
                    return Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                            ),
                            builder: (context) => DraggableScrollableSheet(
                              initialChildSize: 0.6,
                              minChildSize: 0.5,
                              maxChildSize: 0.9,
                              expand: false,
                              builder: (_, controller) => SingleChildScrollView(
                                controller: controller,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0),
                                        child: Image.network(
                                          info.imageUrl,
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        info.title,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        info.description,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Close'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                                child: Image.network(
                                  info.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                info.title,
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}