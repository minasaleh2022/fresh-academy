import 'package:flutter/material.dart';

/// شاشة موحدة لعرض كل قوائم CRUD والتقارير التشغيلية في مكان واحد.
class AdminCrudHub extends StatefulWidget {
  const AdminCrudHub({super.key});

  @override
  State<AdminCrudHub> createState() => _AdminCrudHubState();
}

class _AdminCrudHubState extends State<AdminCrudHub>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, List<Map<String, String>>> _rows;

  final List<_CrudModule> _modules = [
    _CrudModule(
      key: 'users',
      titleAr: 'المستخدمون',
      titleEn: 'Users',
      icon: Icons.people_alt_outlined,
      fields: const [
        _CrudField('name', 'الاسم', 'Name'),
        _CrudField('code', 'الكود', 'Code'),
        _CrudField('role', 'الدور', 'Role'),
      ],
      seed: [
        {'name': 'Ahmed Salah', 'code': 'USR-001', 'role': 'Customer'},
        {'name': 'Mona Adel', 'code': 'USR-002', 'role': 'Supervisor'},
      ],
    ),
    _CrudModule(
      key: 'admins',
      titleAr: 'المديرون',
      titleEn: 'Admins',
      icon: Icons.shield_person,
      fields: const [
        _CrudField('name', 'الاسم', 'Name'),
        _CrudField('email', 'البريد', 'Email'),
        _CrudField('scope', 'النطاق', 'Scope'),
      ],
      seed: [
        {'name': 'Root Admin', 'email': 'root@fresh.com', 'scope': 'Global'},
        {'name': 'Regional', 'email': 'region@fresh.com', 'scope': 'Cairo'},
      ],
    ),
    _CrudModule(
      key: 'supervisors',
      titleAr: 'المشرفون',
      titleEn: 'Supervisors',
      icon: Icons.supervisor_account_outlined,
      fields: const [
        _CrudField('name', 'الاسم', 'Name'),
        _CrudField('zone', 'المنطقة', 'Zone'),
        _CrudField('skills', 'المهارات', 'Skills'),
      ],
      seed: [
        {'name': 'Hossam', 'zone': 'Giza', 'skills': 'Cooling + Gas'},
      ],
    ),
    _CrudModule(
      key: 'orders',
      titleAr: 'البلاغات/الطلبات',
      titleEn: 'Orders & Tickets',
      icon: Icons.receipt_long_outlined,
      fields: const [
        _CrudField('ticket', 'رقم البلاغ', 'Ticket No'),
        _CrudField('product', 'المنتج', 'Product'),
        _CrudField('status', 'الحالة', 'Status'),
      ],
      seed: [
        {'ticket': 'CL-10023', 'product': 'Digital Fridge', 'status': 'Open'},
        {'ticket': 'CL-10024', 'product': 'Gas Heater', 'status': 'Closed'},
      ],
    ),
    _CrudModule(
      key: 'productCategories',
      titleAr: 'فئات المنتجات',
      titleEn: 'Product Categories',
      icon: Icons.widgets_outlined,
      fields: const [
        _CrudField('name', 'الاسم', 'Name'),
        _CrudField('code', 'الكود', 'Code'),
        _CrudField('products', 'عدد المنتجات', 'Products'),
      ],
      seed: [
        {'name': 'التبريد', 'code': 'CAT-CR', 'products': '6'},
        {'name': 'الغاز', 'code': 'CAT-GZ', 'products': '5'},
      ],
    ),
    _CrudModule(
      key: 'products',
      titleAr: 'المنتجات',
      titleEn: 'Products',
      icon: Icons.devices_other_outlined,
      fields: const [
        _CrudField('name', 'الموديل', 'Model'),
        _CrudField('sku', 'الكود', 'SKU'),
        _CrudField('category', 'الفئة', 'Category'),
      ],
      seed: [
        {'name': 'ثلاجة ديجيتال', 'sku': 'FR-DIG-370', 'category': 'التبريد'},
        {'name': 'بوتجاز 5 شعلة', 'sku': 'GAS-5B', 'category': 'الغاز'},
      ],
    ),
    _CrudModule(
      key: 'promo',
      titleAr: 'أكواد الخصم',
      titleEn: 'Promo Codes',
      icon: Icons.percent,
      fields: const [
        _CrudField('code', 'الكود', 'Code'),
        _CrudField('discount', 'الخصم', 'Discount'),
        _CrudField('expires', 'ينتهي في', 'Expires'),
      ],
      seed: [
        {'code': 'FRESH10', 'discount': '10%', 'expires': '2025-12-31'},
      ],
    ),
    _CrudModule(
      key: 'notifications',
      titleAr: 'الإشعارات',
      titleEn: 'Notifications',
      icon: Icons.notifications_active_outlined,
      fields: const [
        _CrudField('title', 'العنوان', 'Title'),
        _CrudField('segment', 'الشريحة', 'Segment'),
        _CrudField('status', 'الحالة', 'Status'),
      ],
      seed: [
        {'title': 'تذكير صيانة', 'segment': 'All', 'status': 'Scheduled'},
      ],
    ),
    _CrudModule(
      key: 'complaints',
      titleAr: 'الشكاوى والمقترحات',
      titleEn: 'Complaints & Suggestions',
      icon: Icons.support_agent,
      fields: const [
        _CrudField('case', 'رقم الحالة', 'Case'),
        _CrudField('channel', 'القناة', 'Channel'),
        _CrudField('status', 'الحالة', 'Status'),
      ],
      seed: [
        {'case': 'CMP-991', 'channel': 'App', 'status': 'Open'},
      ],
    ),
    _CrudModule(
      key: 'terms',
      titleAr: 'الشروط والأحكام',
      titleEn: 'Terms & Conditions',
      icon: Icons.description_outlined,
      fields: const [
        _CrudField('name', 'العنصر', 'Item'),
        _CrudField('version', 'الإصدار', 'Version'),
        _CrudField('status', 'الحالة', 'Status'),
      ],
      seed: [
        {'name': 'خدمة داخل الضمان', 'version': 'v1.0', 'status': 'Active'},
        {'name': 'خدمة خارج الضمان', 'version': 'v1.0', 'status': 'Active'},
      ],
    ),
  ];

  final List<_ReportCard> _reports = const [
    _ReportCard(
      title: 'زمن إغلاق البلاغات',
      description:
          'متوسط زمن الحل من تاريخ الإنشاء حتى التأكيد، مع تصفية حسب المنطقة والمنتج والفني.',
      icon: Icons.speed_outlined,
    ),
    _ReportCard(
      title: 'أرصدة المخازن والتوالف',
      description:
          'رصيد كل مخزن ورصيد أمانة الفنيين، مع حركة صرف/إرجاع وتصفية التالف.',
      icon: Icons.warehouse_outlined,
    ),
    _ReportCard(
      title: 'توزيع البلاغات حسب المهارات والمناطق',
      description:
          'يشمل السحب والإسناد القسري، وتحميل المشرفين بخرائط المناطق والمهارات.',
      icon: Icons.map_outlined,
    ),
    _ReportCard(
      title: 'حسابات مراكز الخدمة المعتمدة',
      description:
          'تجميع البلاغات لكل مركز، مصنعية وقطع غيار، مع تسوية فواتير الفنيين.',
      icon: Icons.account_balance_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _rows = {
      for (final module in _modules)
        module.key: module.seed.map((e) => Map<String, String>.from(e)).toList()
    };
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('وحدة CRUD والتقارير'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'إدارة البيانات / CRUD'),
            Tab(text: 'التقارير والتحليلات'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCrudTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildCrudTab() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _modules.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final module = _modules[index];
        final rows = _rows[module.key] ?? [];
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(module.icon),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${module.titleAr} / ${module.titleEn}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          Text(
                            'إضافة، تعديل، حذف، واستيراد بيانات تجريبية',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () => _openForm(module),
                      icon: const Icon(Icons.add),
                      label: const Text('إضافة / Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      for (final field in module.fields)
                        DataColumn(label: Text('${field.labelAr}\n${field.labelEn}')),
                      const DataColumn(label: Text('إجراءات\nActions')),
                    ],
                    rows: [
                      for (var i = 0; i < rows.length; i++)
                        _buildDataRow(module, rows[i], i),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DataRow _buildDataRow(
      _CrudModule module, Map<String, String> item, int index) {
    return DataRow(cells: [
      for (final field in module.fields)
        DataCell(Text(item[field.key] ?? '—')),
      DataCell(Row(
        children: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            tooltip: 'Edit',
            onPressed: () => _openForm(module, index: index, existing: item),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete',
            onPressed: () {
              setState(() => _rows[module.key]?.removeAt(index));
            },
          ),
        ],
      )),
    ]);
  }

  Widget _buildReportsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: _reports.length,
      itemBuilder: (context, index) {
        final report = _reports[index];
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(report.icon, size: 32),
                const SizedBox(height: 12),
                Text(report.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(report.description),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openForm(_CrudModule module, {int? index, Map<String, String>? existing}) {
    final formKey = GlobalKey<FormState>();
    final controllers = {
      for (final f in module.fields)
        f.key: TextEditingController(text: existing?[f.key] ?? ''),
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${module.titleAr} / ${module.titleEn}',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                for (final field in module.fields) ...[
                  TextFormField(
                    controller: controllers[field.key],
                    decoration: InputDecoration(
                      labelText: '${field.labelAr} / ${field.labelEn}',
                    ),
                    validator: (val) => (val == null || val.isEmpty)
                        ? 'هذا الحقل إجباري'
                        : null,
                  ),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('إلغاء / Cancel'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        final newItem = {
                          for (final field in module.fields)
                            field.key: controllers[field.key]!.text,
                        };
                        setState(() {
                          final list = _rows[module.key]!;
                          if (index == null) {
                            list.add(newItem);
                          } else {
                            list[index] = newItem;
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text(index == null ? 'حفظ / Save' : 'تحديث / Update'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CrudModule {
  final String key;
  final String titleAr;
  final String titleEn;
  final IconData icon;
  final List<_CrudField> fields;
  final List<Map<String, String>> seed;

  const _CrudModule({
    required this.key,
    required this.titleAr,
    required this.titleEn,
    required this.icon,
    required this.fields,
    required this.seed,
  });
}

class _CrudField {
  final String key;
  final String labelAr;
  final String labelEn;
  const _CrudField(this.key, this.labelAr, this.labelEn);
}

class _ReportCard {
  final String title;
  final String description;
  final IconData icon;
  const _ReportCard({
    required this.title,
    required this.description,
    required this.icon,
  });
}
